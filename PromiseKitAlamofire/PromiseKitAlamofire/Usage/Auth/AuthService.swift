//
//  AuthService.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Foundation
import PromiseKit

class AuthService: BaseServices {
    
    func authenticate(using bearer: String) -> Promise<Response<AuthResponse>> {
        return data(AuthResources.bearer, headers: ["Authorization": "Bearer \(bearer)"])
    }
    
}
