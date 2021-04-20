//
//  ViewController.swift
//  PromiseKitAlamofire
//
//  Created by Manish Pandey on 20/04/21.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {

    let service = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authorize(using: "AAAAAAAAAAAAAAAAAAAAAMLheAAAAAAA0%2BuSeid%2BULvsea4JtiGRiSDSJSI%3DEUifiRBkKG5E2XzMDjRfl76ZC9Ub0wnz4XsNiRVBChTYbJcE3F")
    }

    func authorize(using bearerToken: String) {
        firstly {
            self.service.authenticate(using: bearerToken)
        }.done { foo in
            print(foo)
        }.catch { error in
            print(error)
        }
    }
    
}

