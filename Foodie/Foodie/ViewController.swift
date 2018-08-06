//
//  ViewController.swift
//  Foodie
//
//  Created by Pam on 11/6/16.
//  Copyright © 2016 Pam. All rights reserved.
//

import UIKit


class ViewController: UIViewController, GIDSignInUIDelegate {
    var appUser = User()
    let prefs = UserDefaults.standard
    
    @IBOutlet weak var signInBtn: GIDSignInButton!
    var businesses: [Business]!
    
    
            

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
        
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    // Implement these methods only if the GIDSignInUIDelegate is not a subclass of
//    // UIViewController.
//    
//    // Stop the UIActivityIndicatorView animation that was started when the user
//    // pressed the Sign In button
//    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
//        myActivityIndicator.stopAnimating()
//    }
//    
//    // Present a view that prompts the user to sign in with Google
//    func signIn(signIn: GIDSignIn!,
//                presentViewController viewController: UIViewController!) {
//        self.present(viewController, animated: true, completion: nil)
//    }
//    
//    // Dismiss the "Sign in with Google" view
//    func signIn(signIn: GIDSignIn!,
//                dismissViewController viewController: UIViewController!) {
//        self.dismiss(animated: true, completion: nil)
//    }


}

