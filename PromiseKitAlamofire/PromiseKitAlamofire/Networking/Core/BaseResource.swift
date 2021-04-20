//
//  BaseResource.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Alamofire

protocol BaseResource {
    var route: (method: HTTPMethod, path: String) { get }
}
