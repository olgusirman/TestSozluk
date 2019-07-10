//
//  MainEndpoint.swift
//  TestSozluk
//
//  Created by Olgu Sırman on 10.07.2019.
//  Copyright © 2019 MesutGunes. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum MainApi {
    case terms
}

extension MainApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production, .qa, .staging: return "https://raw.githubusercontent.com"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .terms:
            return "/gunesmes/testsozluk/master/terms.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .terms:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

