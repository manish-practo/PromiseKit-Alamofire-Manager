//
//  ClientRequestManager.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Foundation
import Alamofire
import PromiseKit

open class ClientRequestManager {
    
    func request<T: Codable>(_ baseResource: BaseResource,
                             parameters: [String: Any]?,
                             headers: HTTPHeaders) -> Promise<T> {
        
        let method = baseResource.route.method
        let url = buildURL(baseResource.route.path)
        
        // encoded url
        let encodedUrl = try! url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!.asURL()
        
        return AF.request(encodedUrl,
                          method: method,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers)
                            .cURLDescription(calling: { (requestDescription) in
                                debugLog(requestDescription: requestDescription)
                            })
                            .responseCodable()
    }
    
    private func buildURL( _ from: String ) -> String {
        return KRest.appEnv.baseUrl + from
    }

    
}
