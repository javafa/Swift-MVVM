//
//  BaseDatasource.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/05/07.
//

import SwiftUI
import Combine

class BaseDatasource : ObservableObject {
    
    static let BASE = "https://api.github.com"
    
    func subscribe(uri:String) -> URLSession.DataTaskPublisher {
        let full_url = "\(BaseDatasource.BASE)/\(uri)"
        return URLSession.shared.dataTaskPublisher(for: URL(string: full_url)!)
    }
}
