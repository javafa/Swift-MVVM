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
        VStack {
            GithubUserTitle(viewModel: viewModel)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 15))
            
            List(viewModel.users, id:\._id) {
                GithubUserItemView(user: $0)
            }
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
