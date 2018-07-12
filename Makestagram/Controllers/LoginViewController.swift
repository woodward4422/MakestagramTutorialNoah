//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Noah Woodward on 7/5/18.
//  Copyright © 2018 Noah Woodward. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase


typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerOrLoginPressed(_ sender: UIButton) {
       guard let authUI = FUIAuth.defaultAuthUI()
        else { return }
        
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: FUIAuthDelegate {
    

    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        print("Sign up or Login User")
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        // 1
        guard let user = authDataResult?.user
            else {
                print("User is nil")
                return }
        
        
    
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                // handle existing user
                User.setCurrent(user)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
            } else {
                // handle new user
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
        
    

    }
}

