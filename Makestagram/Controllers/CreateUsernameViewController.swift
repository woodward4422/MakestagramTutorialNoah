//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Noah Woodward on 7/10/18.
//  Copyright © 2018 Noah Woodward. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    // ...
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
   
    guard let firUser =  Auth.auth().currentUser,
        let username = usernameTextField.text,
        !username.isEmpty else {return}
        
        UserService.create(firUser, username: username) { (user) in
            guard let _ = user else { return }
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            if let initialViewController = storyboard.instantiateInitialViewController() {
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
            }
            
            
            
        }

            
        }
        
        
    }

