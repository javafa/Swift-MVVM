//
//  GithubUserView.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/04/22.
//

import SwiftUI
import Combine

struct GithubUserView: View {
    
    @ObservedObject var viewModel = GithubUserViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.users, id:\.id) {
                GithubUserItemView(user: $0)
            }
            .navigationTitle("Github User Api")
            .onAppear {
                self.viewModel.fetchUsers()
            }
        }
    }
}

struct GithubUserView_Preview: PreviewProvider {
    static var previews: some View {
        GithubUserView()
    }
}
