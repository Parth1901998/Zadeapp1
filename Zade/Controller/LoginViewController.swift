//
//  LoginViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 08/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class LoginViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @IBAction func signWithGoogle(_ sender: UIButton) {
        
         GIDSignIn.sharedInstance().signIn()

//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let UserProfileViewController = storyBoard.instantiateViewController(withIdentifier: "Profile") as! UserProfileViewController
//        self.present(UserProfileViewController, animated:true, completion:nil)

        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let UserPostViewController = storyBoard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
        self.present(UserPostViewController, animated:true, completion:nil)
        
//        let userpost = storyboard?.instantiateViewController(withIdentifier: "UserPostViewController") as! UserPostViewController
//        self.navigationController?.pushViewController(userpost, animated: true)
        
        
        
        
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Google Sing In didSignInForUser")
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
        // When user is signed in
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
            }
        })
    }
    // Start Google OAuth2 Authentication
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
        
        // Showing OAuth2 authentication window
        if let aController = viewController {
            present(aController, animated: true) {() -> Void in }
        }
    }
    // After Google OAuth2 authentication
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
        // Close OAuth2 authentication window
        dismiss(animated: true) {() -> Void in }
    }
    
    
    @IBAction func backToHome(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
              let IntroductionSlide = storyBoard.instantiateViewController(withIdentifier: "Introduction") as! IntroductionSlide
               self.present(IntroductionSlide, animated:true, completion:nil)
        
//    let vc = IntroductionSlide()
//     navigationController?.popViewController(animated: true)
        
        
    }
    

}
