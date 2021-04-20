//
//  AuthResponse.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Foundation

struct AuthResponse: Codable {
    let authenticated: Bool
    let token: String
}
