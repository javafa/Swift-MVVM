//
//  ApiCombine.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/04/27.
//

import Foundation
import Combine
import Alamofire

class APIHandler {
    
    static let BASE = "https://api.github.com"
    
    private var _url : String = ""
    var url : String  {
        get { return "\(APIHandler.BASE)\(_url)" }
        set(value) { _url = value }
    }

    func handleResponse<T: Decodable>(_ response: DataResponse<T, AFError>) -> Any? {
        switch response.result {
        case .success:
            return response.value
        case .failure:
            return nil
        }
    }
}
