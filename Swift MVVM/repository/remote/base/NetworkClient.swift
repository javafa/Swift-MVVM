//
//  NetworkClient.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/10.
//

import Foundation
import Combine

struct NetworkClient {
    private let baseURL = "https://api.github.com"
    private var networkDispatcher: NetworkDispatcher!
    
    static var instance = NetworkClient()
    
    private init(networkDispatcher: NetworkDispatcher = NetworkDispatcher()) {
        self.networkDispatcher = networkDispatcher
    }
    
    func dispatch<T: Request>(_ request: T) -> AnyPublisher<T.ReturnType, NetworkRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            return Fail(outputType: T.ReturnType.self, failure: NetworkRequestError.badRequest)
                .eraseToAnyPublisher()
        }
        typealias RequestPublisher = AnyPublisher<T.ReturnType, NetworkRequestError>
        let requestPublisher: RequestPublisher = networkDispatcher.dispatch(request: urlRequest)
        return requestPublisher.eraseToAnyPublisher()
    }
}
