//
//  ViewController.swift
//  Instagram
//
//  Created by Игорь Силаев on 13/04/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit
import SwiftInstagram

class ViewController: UIViewController{
    @IBOutlet weak var Auth: UILabel!
    @IBOutlet weak var kek: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let api = Instagram.shared
        api.login(from: navigationController!, withScopes: [.all], success: {
            let lol = "Kek"
            self.kek.text = lol
        }, failure: { error in
            print(error.localizedDescription)
        })
        let r = api.isAuthenticated
        Auth.text = String(r)
        
    }


}

