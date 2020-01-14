//
//  ViewController.swift
//  sociLeaks
//
//  Created by Can Talay on 14.01.2020.
//  Copyright © 2020 Can Talay. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self

    }

    
    @IBAction func buttonAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    

}

//MARK: - GIDSingInDelegate - USER LOGIN WITH GOOGLE!

extension ViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("IMHERE")
        if let error = error {
          print(error)
          return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        print("Connected with : \(credential)")
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                print("Login Succesfully!")
            }
        }
    }
    
    
}


