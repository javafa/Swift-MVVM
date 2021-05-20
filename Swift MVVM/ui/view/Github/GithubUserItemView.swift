//
//  GithubUserItemView.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/04/22.
//

import SwiftUI

struct GithubUserItemView: View {
    
    private let user:GithubUser
    
    init(user:GithubUser) {
        self.user = user
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.name)
                .font(Spoqa.h5_18_bold)
                .foregroundColor(Color("GRAY800"))
            Text(user._id ?? "none")
                .font(Spoqa.body2_14)
                .foregroundColor(Color("GRAY600"))
        }
    }
}
