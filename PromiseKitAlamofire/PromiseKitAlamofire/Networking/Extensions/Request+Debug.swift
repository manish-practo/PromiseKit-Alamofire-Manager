//
//  Request+Debug.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Alamofire

extension Request {
 
    public func debugLog() -> Self {
        #if DEBUG
        print(self)
        
        #endif
        return self
    }
    
}

public func debugLog(requestDescription: String) {
    #if DEBUG
    print(requestDescription)
    #endif
}
