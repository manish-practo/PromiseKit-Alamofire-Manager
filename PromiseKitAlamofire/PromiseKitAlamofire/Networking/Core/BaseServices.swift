//
//  BaseServices.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Foundation
import PromiseKit
import Alamofire

public class BaseServices: ClientRequestManager {
    
    func attempt<T>(maximumRetryCount: Int = 3,
                    delayBeforeRetry: DispatchTimeInterval = .seconds(2),
                    _ body: @escaping () -> Promise<T>) -> Promise<T> {
        
        var attempts = 0
        func attempt() -> Promise<T> {
            attempts += 1
            return body().recover { error -> Promise<T> in
                if let mappedError = error as? RestResponseError {
                    guard mappedError != RestResponseError.accessForbiden else {
                        
                        throw error
                    }
                }
                
                guard attempts < maximumRetryCount else { throw error }
                return after(delayBeforeRetry).then(on: nil, attempt)
            }
        }
        return attempt()
    }
    
    func data<T: Codable>( _ baseResource: BaseResource,
                           headers: HTTPHeaders = ["Content-Type": "application/json"],
                           parameters: [String: Any]? = nil)-> Promise<Response<T>> {
        
        attempt { () -> Promise<Response<T>> in
            return self.execute(action: {
                super.request(baseResource, parameters: parameters, headers: headers)
            })
        }
                
    }
    
}

// MARK: - Helpers
extension BaseServices {
    private func execute<T>(action:() -> Promise<T>) -> Promise<Response<T>> {
        return Promise { seal in
            firstly {
                action()
            }.done({ result in
                seal.fulfill(Response<T>(result: result, error: nil))
            }).catch({ error in
                seal.reject(error)
            })
        }
    }
}
