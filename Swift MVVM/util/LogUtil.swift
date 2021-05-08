//
//  Logger.swift
//  plangramios
//
//  Created by DONHO KO on 10/05/2019.
//  Copyright © 2019 ios3. All rights reserved.
//

import Foundation

class LogUtil {
    static func i(tag:String, msg:String) {
        print("[Info] \(tag) : \(msg)")
    }
    
    static func d(tag:String, msg:String) {
        print("[Debug] \(tag) : \(msg)")
    }
    
    static func d(_ object:Any,_ msg:String) {
        #if DEBUG
        let tag = String(describing: object.self)
        d(tag:tag, msg:msg)
        #endif
    }

    static func e(tag:String, msg:String) {
        print("[Error] \(tag) : \(msg)")
    }
    
    static func e(_ object:Any,_ msg:String) {
        #if DEBUG
        let tag = String(describing: object.self)
        e(tag:tag, msg:msg)
        #endif
    }
}
