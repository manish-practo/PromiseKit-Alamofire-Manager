//
//  AuthResources.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Alamofire

enum AuthResources: BaseResource {
    
    case bearer
    
}

extension AuthResources {
    
    var route: (method: HTTPMethod, path: String) {
        switch self {
        case .bearer:
            return (.get, "bearer")
        }
    }
    
}
