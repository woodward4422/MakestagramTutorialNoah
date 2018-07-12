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
        
        // 2
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let user = User(snapshot: snapshot) {
                print("Welcome back, \(user.username).")
            } else {
                print("New user!")
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
            }
        })
    

    }
}

