//
//  Request.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/10.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
    associatedtype ReturnType: Codable
}

extension Request {
    var method: HTTPMethod { return .GET }
    var contentType: String { return  "application/json" }
    var queryParams: [String: String]? { return nil }
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
}

extension Request {
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        else {
            return nil
        }
        return httpBody
    }
    
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers
        return request
    }
}

// Sample

struct Sample: Codable {
    var title: String
    var completed: Bool
}

struct RequestSample: Request {
    typealias ReturnType = [Sample]
    var path = "/samples"
}


