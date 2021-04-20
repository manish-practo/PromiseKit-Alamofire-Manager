//
//  Response.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Foundation

struct Response<T> {
    var result: T?
    var error: ResponseError<T>?
}

struct ResponseError<T> {
    let statusCode: Int
    let message: String
    let properties: T?
}
