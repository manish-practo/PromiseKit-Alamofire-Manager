//
//  DataRequest+ResponseCodable.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Foundation
import PromiseKit
import Alamofire

extension Alamofire.DataRequest {
    
    // Return a Promise for a Codable
    public func responseCodable<T: Codable>() -> Promise<T> {
        return Promise<T> { seal in
            responseData() { response in

                guard let gaurdedResponse = response.response else { return }
                
                switch gaurdedResponse.statusCode {
                // Success
                case 200:
                    guard let value = response.data else {
                        assertionFailure("response.data property is nil")
                        seal.reject(RestResponseError.noData)
                        return
                    }
                    
                    DataProcessor<T>.deserialize(value) { (decodedResponse, error) in
                        if error != nil {
                            assertionFailure()
                            seal.reject(error!)
                        } else {
                            seal.fulfill(decodedResponse!)
                        }
                    }
                
                // Failed
                case 401:
                    // Unauthorised
                    // Show login screen
                    
                    // this will allow retry after token accessed
                    seal.reject(RestResponseError.notAuthorised)
                    
                case 403:
                    seal.reject(RestResponseError.accessForbiden)
                    
                case 400..<500:
                    // Report to firebase
                    
                    // Issue with server (access or gateway)
                    self.processFailureResponse(error: RestResponseError.badRequest,
                                                requestedAPI: self.request?.url?.absoluteString,
                                                response: response.response)
                    
                    seal.reject(RestResponseError.badRequest)
                    
                case 500..<600:
                    // Report to firebase
                    // No Server response
                    self.processFailureResponse(error: RestResponseError.noServerResponse,
                                                requestedAPI: self.request?.url?.absoluteString,
                                                response: response.response)
                    
                    seal.reject(RestResponseError.noServerResponse)
                    
                default:
                    seal.reject(RestResponseError.unknown)
                }
                
            }
        }
    }
    
    
    fileprivate func processFailureResponse(error: RestResponseError,
                                            requestedAPI: String?,
                                            response: HTTPURLResponse?) {
        print("error: \(error)\nResponse: \(response.debugDescription)")
        assertionFailure()
    }
    
}
