//
//  Api.swift
//  Swift MVVM
//
//  Created by DONHO KO on 2021/04/22.
//

import Foundation
import Alamofire

struct LegacyApiHandler {

    static let BASE_URL : String = "https://api.flow9.net"
    
    static var headers : HTTPHeaders = ["X-Platform": "IOS"]
    
    static var session: Alamofire.Session = {
        let configuration = URLSessionConfiguration.af.default
        return Alamofire.Session(configuration: configuration)
    }()
    
    static func request<T: Codable>( url:String,
          method : HTTPMethod,
          parameters : Parameters? = nil,
          encoding : BaseRequest.Encoding = BaseRequest.Encoding.json,
          completion : @escaping (T) -> Void,
          errorCompletion: @escaping (ErrorResponse) -> Void){
        
        let fullUrl = BASE_URL + url

        let enc:ParameterEncoding = (encoding == BaseRequest.Encoding.parameter) ? URLEncoding.default : JSONEncoding.default
        
        headers["x-auth-token"] = Default.shared.sign_token
        
        session.request(fullUrl, method: method, parameters: parameters, encoding: enc, headers: headers).response { (response) in
            
            debugPrint(response)
            
            switch response.result {
            
                case .success(_):
                    if let data = response.data, let statusCode = response.response?.statusCode {
                        do {
                            let jsonString = String(data: data, encoding: .utf8)
                            let jsonData = jsonString!.data(using: .utf8)
                            let decoder = JSONDecoder()
                            switch statusCode {
                                case 200 : let result = try decoder.decode(T.self, from:jsonData!)
                                    completion(result)
                                default : let error = try decoder.decode(ErrorResponse.self, from:jsonData!)
                                    errorCompletion(error)
                            }
                        } catch let error { errorCompletion(ErrorResponse(error.localizedDescription, code:ErrorCode.Parsing)) }
                    } else { errorCompletion(ErrorResponse("no data", code:ErrorCode.NoData)) }
                case .failure(let error): errorCompletion(ErrorResponse(error.localizedDescription))
            }
        }
    }
}



