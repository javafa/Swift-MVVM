//
//  GithubRepository.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/07.
//

import SwiftUI
import Combine

class GithubRepository {

    private var remote = GithubDatasource()
    private var local = GithubUserDAO()
    
    func getUsers() -> AnyPublisher<[GithubUser], Never> {
        debugPrint("GithubRepository", "getUsers()")
        return remote.getUsers()
            .map { $0.data }
            .decode(type: [GithubUser].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
