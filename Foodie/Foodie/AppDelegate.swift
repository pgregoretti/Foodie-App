//
//  AppDelegate.swift
//  Foodie
//
//  Created by Pamelons on 11/6/16.
//  Copyright © 2016 Pam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    //var storyboard = UIStoryboard(name: "Main", bundle: nil)
    //var vc = storyboard.instantiateViewController(withIdentifier: "mainview") as! ViewController
    var vc = ViewController()
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        return true

    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
//    func application(application: UIApplication,
//                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
//        return GIDSignIn.sharedInstance().handle(url as URL!,
//                                                    sourceApplication: sourceApplication,
//                                                    annotation: annotation)
//    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let checkGoogle = GIDSignIn.sharedInstance().handle(url as URL!,sourceApplication: sourceApplication,annotation: annotation)
        return checkGoogle
    }
    
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            //let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            
            vc.prefs.set(userId, forKey: "username")
            vc.prefs.set(email, forKey: "useremail")
            vc.prefs.set(givenName, forKey: "givenname")
            vc.prefs.set(familyName, forKey: "lastname")
            vc.prefs.set(fullName, forKey: "fullname")
            vc.prefs.set(givenName, forKey: "firstName")
            print("TEST: " + vc.prefs.string(forKey: "firstName")!)
            
            //print(vc.appUser.email)
            
            self.window?.rootViewController?.performSegue(withIdentifier: "logInSuccess", sender: self)
            
            //vc.presentViewController(, animated: true, completion: nil)
            
           // let mapViewControllerObj = vc.storyboard?.instantiateViewControllerWithIdentifier("LISuccessViewController") as? UIViewController
            //self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
            
            //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            //let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("nextView") as! LISuccessViewController
           // self.presentViewController(nextViewController, animated:true, completion:nil)
            
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation))
        {
            print("landscape")
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
        {
            print("Portrait")
        }
        
    }

}

