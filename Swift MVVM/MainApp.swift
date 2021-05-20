//
//  Swift_MVVMApp.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/04/19.
//

import SwiftUI
import AlamofireNetworkActivityLogger

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
    
    init() {
        #if DEBUG
            NetworkActivityLogger.shared.level = .debug
            NetworkActivityLogger.shared.startLogging()
        #endif
    }
}
