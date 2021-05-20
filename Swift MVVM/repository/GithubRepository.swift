//
//  GithubRepository.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/07.
//

import SwiftUI
import Combine

class GithubRepository {

    private var remote = RestService()
    private var local = GithubUserDAO()
    
    func getUsers() -> AnyPublisher<[GithubUser], SwitError> {
        return remote.test.get()
            .map {
                return $0.value
            }
            .eraseToAnyPublisher()
    }
    
    func postUser(_ user:GithubUserRequest) -> AnyPublisher<GithubUser, SwitError> {
        return remote.test.post(body: user)
            .map {
                return $0.value
            }
            .eraseToAnyPublisher()
    }
}
