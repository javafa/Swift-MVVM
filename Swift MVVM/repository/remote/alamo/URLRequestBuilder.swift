//
//  URLRequestBuilder.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/10.
//

import Foundation
import Alamofire

protocol URLRequestBuilder : URLRequestConvertible {
    var baseURL: URL { get }
    var requestURL: URL { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var urlRequest: URLRequest { get }
}

extension URLRequestBuilder {
    var baseURL: URL { NetworkConfig.baseURL }
    
    var requestURL: URL { baseURL.appendingPathComponent(path, isDirectory: false)}
    
    var encoding: ParameterEncoding {
        switch method {
        case .GET:
            return URLEncoding.default
        default :
            return JSONEncoding.default
        }
    }
    
    var headers: HTTPHeaders {
        return HTTPHeaders()
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.name)
        }
        return request
    }
    
    public func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
}
