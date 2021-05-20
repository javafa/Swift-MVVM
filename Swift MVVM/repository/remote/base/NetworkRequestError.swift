//
//  NetworkRequestError.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/10.
//

import Foundation

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}
