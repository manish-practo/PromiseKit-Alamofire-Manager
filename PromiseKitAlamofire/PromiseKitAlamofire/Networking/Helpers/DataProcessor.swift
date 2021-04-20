//
//  DataProcessor.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import Foundation

struct DataProcessor<T: Codable> {
    
    // serialize
    static func serialize ( data: T ) -> [String: Any] {
        return data.asDictionary()
    }
    
    
    // deserialize
    static func deserialize (_ data: Data,
                             onCompilation: @escaping (_ data: T?, _ error: Error?) -> Void) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            onCompilation(decodedData, nil)
        } catch {
            print("Error while decoding \(error)")
            assertionFailure("Error while decoding data")
            
            onCompilation(nil, error)
        }
    }
}
