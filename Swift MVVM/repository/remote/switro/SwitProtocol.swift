//
//  SwitProtocol.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/20.
//

import Foundation
import Alamofire

protocol SwitProtocol {
    var baseUrl: String { get }
    func initialize(interceptor:SwitInterceptor?)
}

extension SwitProtocol {
    
    func initialize(interceptor:SwitInterceptor?=nil) {
        let mirror = Mirror(reflecting: self)

        for child in mirror.children {
            if let switro = child.value as? Switro {
                if let rest = switro.rest as? Switrest {
                    rest.baseUrl = self.baseUrl
                    rest.interceptor = interceptor
                }
            }
        }
    }
}

protocol SwitInterceptor {
    func interceptRequest(orgRequest:URLRequest) -> URLRequest
    func interceptResponse(orgResponse:URLResponse?)
}
