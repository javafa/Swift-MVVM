//
//  GithubUserApi.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/10.
//

import Foundation

struct RestService : SwitProtocol {
    
    var baseUrl: String = "https://crudcrud.com/api/aa4b0e994ba54736811d827740970ff8"

    init() {
        initialize(interceptor: RestInterceptor())
    }
    
    @Switro("/test")
    var test: Switrest
}

class RestInterceptor: SwitInterceptor {
    func interceptRequest(orgRequest: URLRequest) -> URLRequest {
        var newRequest = orgRequest
        newRequest.setValue("Bearer /(token here!)/", forHTTPHeaderField: "Authorization")
        return newRequest
    }
    
    func interceptResponse(orgResponse: URLResponse?) {
        print("[Swit] interceptResponse:", orgResponse)
    }
}
