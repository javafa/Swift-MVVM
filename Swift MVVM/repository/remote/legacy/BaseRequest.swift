//
//  Request.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/04.
//

import Foundation

class BaseRequest : Codable {
    
    enum Encoding {
        case json
        case parameter
    }
    
    func toParameters() -> [String:Any] {
        let mirror = Mirror(reflecting: self)
        var parameters : [String:Any] = [:]
        for item in mirror.children {
            parameters.updateValue( item.value, forKey:item.label!)
        }
        return parameters
    }
    
    func toBody() -> String {
        let mirror = Mirror(reflecting: self)
        var parameters = ""
        for item in mirror.children {
            parameters += "&\(item.label!)=\(item.value)"
        }
        return parameters
    }
    
}

extension BaseRequest {
   public func debugLog() -> Self {
      #if DEBUG
         debugPrint(self)
      #endif
      return self
   }
}
