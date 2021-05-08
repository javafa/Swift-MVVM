//
//  GithubUserViewModel.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/04/22.
//

import Combine
import SwiftUI

class GithubUserViewModel : BaseViewModel {
    private var repository = GithubRepository()
    
    @Published var users: [GithubUser] = []
    
    func fetchUsers() {
        repository.getUsers()
            .receive(on: RunLoop.main)
            .assign(to: \.users, on: self)
            .store(in: &cancelables)
    }
}
