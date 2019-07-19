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
import FBSDKLoginKit
import FirebaseAuth
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate, LoginButtonDelegate{
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
            
            //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            //let UserPostViewController = storyBoard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
            //self.present(UserPostViewController, animated:true, completion:nil)
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabbar") as? UITabBarController
            
            self.navigationController?.pushViewController(vc!, animated: true)
            
            }
            
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBOutlet weak var FBlog: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @IBAction func signWithGoogle(_ sender: UIButton) {
        
         GIDSignIn.sharedInstance().signIn()


        
    }
    
    
    
    @IBAction func fbLogin(_ sender: Any) {
   
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let UserPostViewController = storyBoard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
                    self.present(UserPostViewController, animated:true, completion:nil)
                    
//                    let BestSeller = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
//                    self.navigationController?.pushViewController(BestSeller, animated: true)
//
                    self.getFBUserData()
                }
            }
        }
        
       
    }
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result)
                }
            })
        }
        
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
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let UserPostViewController = storyBoard.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
            self.present(UserPostViewController, animated:true, completion:nil)
            
            
            
            
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
        
//        navigationController?.popViewController(animated: true)
      self.dismiss(animated: true, completion: nil)
        
        
    }
    

}
