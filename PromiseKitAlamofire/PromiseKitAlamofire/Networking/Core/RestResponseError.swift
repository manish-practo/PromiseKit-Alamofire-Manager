//
//  RestResponseError.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Foundation

enum RestResponseError: Error {
    case unknown
    case noData
    case noServerResponse
    case notAuthorised
    case badRequest
    case accessForbiden
    
    var message: String {
        
        switch self {
        case .unknown:
            return "Something went wrong."
        case .noData:
            return "No response data."
        case .noServerResponse:
            return "No server response."
        case .notAuthorised:
            return "User not authorised!, login required, please restart the app."
        case .badRequest:
            return "Bad request, request method or parameter may be incorrect."
        case .accessForbiden:
            return "We are sorry, but you do not have permissions to view the resource."
        }
        
    }
}
