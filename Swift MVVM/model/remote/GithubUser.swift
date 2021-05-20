//
//  GithubUser.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/07.
//

import Foundation

struct GithubUserRequest : Switype {
    var age:Int
    var name:String
    var address:String?
    var phone:String?
    var email:String?
    var sub:GithubUserSub = GithubUserSub()
}

struct GithubUserSub : Switype {
    var subId:Int = 0
}

struct GithubUser : Switype {
    var _id:String?
    var age:Int
    var name:String
    var address:String?
    var phone:String?
    var email:String?
}
