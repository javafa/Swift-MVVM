//
//  GithubUserApi.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/04/27.
//

import Foundation
import Combine
import Alamofire

class GithubUserApiLegacy: APIHandler {
    
    @Published var response: Array<GithubUser>? = nil
    @Published var isLoading = false
    
    func getUsers() {
        let url = "/users"
        isLoading = true
        AF.request(url, method: .get).responseDecodable { [weak self] (response: DataResponse<Array<GithubUser>, AFError> ) in
            guard let weakSelf = self else { return }
            guard let result = weakSelf.handleResponse(response) as? Array<GithubUser> else {
                weakSelf.isLoading = false
                return
            }
            weakSelf.isLoading = false
            weakSelf.response = result
        }
    }
    
    class UserResponse : BaseResponse<Array<GithubUser>> {} // just example. not use here!
}
