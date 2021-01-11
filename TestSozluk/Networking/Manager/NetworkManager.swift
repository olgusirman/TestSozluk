//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/11.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    static let environment : NetworkEnvironment = .production
    static let MovieAPIKey = ""
    
    let router = Router<MainApi>()
    
    func getTerms(completion: @escaping (_ movie: [Term]?, _ error: String?) -> Void ) {
        router.request(.terms) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
//                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        
                        // Map my data to codable object
                        
                        let apiResponse = try JSONDecoder().decode([Term].self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        //print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getReadme(completion: @escaping (_ home: Home?, _ error: String?) -> Void ) {
        router.request(.readme) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard data != nil else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
//                        print(responseData)
                        let readmeTxt = String(data: data!, encoding: .utf8)
                        print(readmeTxt as Any)
                        
                        // Map my data to codable object
                        
                        let apiResponse = Home.init(readme: readmeTxt!)
                        completion(apiResponse,nil)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
