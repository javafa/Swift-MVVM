//
//  Switrest.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/20.
//

import Foundation
import Alamofire
import Combine

class Switrest {
    var baseUrl: String = "none"
    var interceptor: SwitInterceptor? = nil
    private var path: String = ""
    
    init(path:String) {
        self.path = path
    }
    
    var method: Alamofire.HTTPMethod = .get
    var parameters: Parameters? = nil
    var contentType: String = "application/json"
    
    var body: Switype? = nil
    var headers: [String: String]?
    
    private var paths: SwitParam? = nil
    private var queries: SwitParam? = nil
    
    private var baseURL: URL {
        print("baseUrl", baseUrl)
        return URL(string: baseUrl)!
    }
    
    private var compositedURL: URL {
        let compositedPath = "\(compositedPaths)\(compositedQueries)"
        return baseURL.appendingPathComponent(compositedPath , isDirectory: false)
    }
    
    private var compositedPaths : String {
        var compositedPath = path
        if let rawPaths = paths {
            for (key, value) in rawPaths {
                compositedPath = compositedPath.replacingOccurrences(of: "{\(key)}", with: "\(value)")
            }
            debugPrint("pathResult:", compositedPath)
        }
        return compositedPath
    }
    
    private var compositedQueries : String {
        var queryPart = ""
        if let rawQueries = queries {
            for (key, value) in rawQueries {
                queryPart = "\(queryPart)&\(key)=\(value)"
            }
            let startIdx:String.Index = queryPart.index(queryPart.startIndex, offsetBy: 1)
            let queryResult = queryPart[startIdx...]
            debugPrint("queryResult:", queryResult)
            queryPart = "?\(queryResult)"
        }
        return queryPart
    }

    private var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    private var urlRequest: URLRequest {
        var request = URLRequest(url: compositedURL)
        request.httpMethod = method.rawValue
        
        if let rawHeaders = headers {
            for (key, value) in rawHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
    private func urlParamRequest() throws -> URLRequest {
        if let rawBody = body {
            parameters = rawBody.toJson()
        }
        return try encoding.encode(urlRequest, with: parameters)
    }
}

extension Switrest {
    func get<T: Codable>(paths:SwitParam?=nil, queries:SwitParam?=nil, headers:[String: String]?=nil) -> AnyPublisher<SwitResponse<T>, SwitError> {
        self.method = .get
        self.paths = paths
        self.queries = queries
        self.headers = headers
        
        return request(T.self)
    }
}

extension Switrest {
    func post<T: Codable>(paths:SwitParam?=nil, queries:SwitParam?=nil, body:Switype?=nil, params:SwitParam?=nil, headers:[String: String]?=nil) -> AnyPublisher<SwitResponse<T>, SwitError> {
        self.method = .post
        self.paths = paths
        self.queries = queries
        self.headers = headers
        self.body = body
        
        return request(T.self)
    }
}

extension Switrest {
    func put<T: Codable>(paths:SwitParam?=nil, queries:SwitParam?=nil, body:Switype?=nil, params:SwitParam?=nil, headers:[String: String]?=nil) -> AnyPublisher<SwitResponse<T>, SwitError> {
        self.method = .put
        self.paths = paths
        self.queries = queries
        self.headers = headers
        self.body = body
        
        return request(T.self)
    }
}

extension Switrest {
    func delete<T: Codable>(paths:SwitParam?=nil, queries:SwitParam?=nil, body:Switype?=nil, params:SwitParam?=nil, headers:[String: String]?=nil) -> AnyPublisher<SwitResponse<T>, SwitError> {
        self.method = .delete
        self.paths = paths
        self.queries = queries
        self.headers = headers
        self.body = body
        
        return request(T.self)
    }
}

extension Switrest {
    func patch<T: Codable>(paths:SwitParam?=nil, queries:SwitParam?=nil, body:Switype?=nil, params:SwitParam?=nil, headers:[String: String]?=nil) -> AnyPublisher<SwitResponse<T>, SwitError> {
        self.method = .patch
        self.paths = paths
        self.queries = queries
        self.headers = headers
        self.body = body
        
        return request(T.self)
    }
}

extension Switrest {
    private func request<T: Codable>(_ type:T.Type) -> AnyPublisher<SwitResponse<T>, SwitError> {
        
        debugPrint("[Swit] request", urlRequest)
        debugPrint("[Swit] header", headers)
        debugPrint("[Swit] body", body)
        
        do {
            var request = try urlParamRequest()
            
            // interceptor 처리
            if let interceptor = self.interceptor {
                request = interceptor.interceptRequest(orgRequest: request)
            }
            
            return AF.request(request)
            .validate()
            .publishDecodable(type: T.self)
            .tryMap { result -> SwitResponse<T> in
                
                if let interceptor = self.interceptor {
                    interceptor.interceptResponse(orgResponse: result.response)
                }
                
                if result.error != nil {
                    debugPrint("[Swit] error", "\(result)")
                    throw SwitError(description: result.error?.errorDescription)
                }
                if let data = result.data {
                    let value = try JSONDecoder().decode(T.self, from: data)
                    return SwitResponse(value: value, response: result.response!)
                } else {
                    return SwitResponse(value: Empty.emptyValue() as! T, response: result.response!)
                }
            }
            .mapError({ (error) -> SwitError in
                if let switError = error as? SwitError {
                    debugPrint("[Swit] switError", "\(switError)")
                    return switError
                } else {
                    return SwitError(description: error.asAFError?.errorDescription)
                }
            })
            .receive(on: DispatchQueue.global())
            .eraseToAnyPublisher()
        } catch (let error) {
            debugPrint("[Swit] try error", "\(String(describing: error.asAFError?.errorDescription))")
            return Fail(outputType: SwitResponse<T>.self, failure: SwitError(description: error.asAFError?.errorDescription))
                  .eraseToAnyPublisher()
        }
    }
}
