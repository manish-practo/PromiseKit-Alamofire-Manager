//
//  KRest.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Foundation

struct KRest {
    
    // Load this from info.plist or any config file
    public static var appEnv: Env {
        return Env.live
    }
    
    public enum Env: String {
        case dev = "Dev"
        case qa = "QA"
        case live = "Live"
        
        public var baseUrl: String {
            switch self {
            case .dev:
                return API.dev
            case .qa:
                return API.qa
            case .live:
                return API.live
            }
        }
        
    }
    
    private struct API {
        public static let dev = "https://httpbin.org/" // dev server base url
        public static let qa = "https://httpbin.org/" // qa server base url
        public static let live = "https://httpbin.org/"  // live server base url
    }
    
}
