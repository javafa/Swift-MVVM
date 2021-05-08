//
//  BaseViewModel.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/07.
//

import Combine
import SwiftUI

class BaseViewModel : ObservableObject {
    var cancelables : Set<AnyCancellable> = []
}
