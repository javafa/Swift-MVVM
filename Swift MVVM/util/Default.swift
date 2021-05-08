//
//  Default.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/04/27.
//

import Foundation

class Default {
    static let shared = Default()
    private init() {}
    
    func signOut() {
        sign_token = ""
    }
    
    // User Basic Info.
    var uid: String {
        get {return UserDefaults.standard.string(forKey: "uid") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "uid") }
    }
    
    var name: String {
        get {return UserDefaults.standard.string(forKey: "name") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "name") }
    }

    var sign_token: String {
        get {return UserDefaults.standard.string(forKey: "sign_token") ?? ""}
        set { UserDefaults.standard.set(newValue, forKey: "sign_token") }
    }
}
