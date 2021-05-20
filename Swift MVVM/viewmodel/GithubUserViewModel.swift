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
    @Published var error: String = ""
    @Published var loading = false
    
    func fetchUsers() {
        loading = true
        repository.getUsers()
            .tryMap {
                $0
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { status in
                    switch status {
                    case .finished :
                        self.loading = false
                    case .failure(let error) :
                        guard let switerror = error as? SwitError else {
                            debugPrint("failure", "\(error.localizedDescription)")
                            self.error = error.localizedDescription
                            return
                        }
                        if let msg = switerror.description {
                            debugPrint("failure swit", "\(msg)")
                            self.error = msg
                        }
                    }
                }
                , receiveValue: { self.users = $0 }
            )
            .store(in: &cancelables)
    }
    
    func addItem() {
        let user = GithubUserRequest(age:23, name:"Hello")
        
        repository.postUser(user)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { status in
                    switch status {
                    case .finished :
                        self.fetchUsers()
                        self.loading = false
                    case .failure(let error) :
                        guard let switerror = error as? SwitError else {
                            debugPrint("failure", "\(error.localizedDescription)")
                            self.error = error.localizedDescription
                            return
                        }
                        if let msg = switerror.description {
                            debugPrint("failure swit", "\(msg)")
                            self.error = msg
                        }
                    }
                }, receiveValue: {_ in }
            )
            .store(in: &cancelables)
    }
}
