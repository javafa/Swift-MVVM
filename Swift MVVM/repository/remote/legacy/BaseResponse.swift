//
//  BaseResponse.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/04.
//

import Foundation

class BaseResponse<T:Codable> : Codable {
    var data:Array<T>?
    let code:String?
    let message:String?
    
    func setData(data:Array<T>) {
        self.data = data
    }
}

class BaseSingleResponse<T:Codable> : Codable {
    var data:T?
    let code:String?
    let message:String?
    
    func setData(data:T) {
        self.data = data
    }
}


enum ErrorCode : String, Codable {
    case NoData
    case Error
    case Parsing
}

class ErrorResponse : Codable {
    
    var data:String? = nil
    let code:ErrorCode
    let message:String
    
    init(_ message:String, code:ErrorCode=ErrorCode.Error) {
        self.code = code
        self.message = message
    }
}
