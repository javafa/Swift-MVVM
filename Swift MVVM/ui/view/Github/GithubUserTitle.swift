//
//  GithubUserTitle.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/20.
//

import SwiftUI
import Combine

struct GithubUserTitle: View {
    
    var viewModel:GithubUserViewModel
    
    var body: some View {
        HStack {
            Text("Title")
                .font(Spoqa.h2_32)
                .foregroundColor(Color("GRAY800"))
            Spacer()
            Button("+", action:viewModel.addItem)
        }
    }
}

