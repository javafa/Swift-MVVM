//
//  BaseAnnotation.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/10.
//

import Combine
import Alamofire

@propertyWrapper
struct Switro {
    var rest: Switrest
    
    init(_ url:String) { // body:[String: Any]?=nil, headers: [String: String]?=nil
        self.rest = Switrest(path: url)
    }
    
    var wrappedValue: Switrest {
        get { rest }
        set { rest = newValue }
    }
}

typealias SwitParam = [String: (Int, String)]

protocol Switype : Codable {
    /* use request and response type */
    func toJson() -> Parameters
}

extension Switype {
    
    func toJson() -> [String:Any] {
        let data = try! JSONEncoder.init().encode(self)
        let dictionary = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
        return dictionary
    }
}

struct SwitResponse<T> {
    let value:T
    let response: URLResponse
}

struct SwitError: Error {
    let description:String?
}

struct ErrorData: Codable {
    var statusCode: Int
    var message: String
    var error: String?
}




