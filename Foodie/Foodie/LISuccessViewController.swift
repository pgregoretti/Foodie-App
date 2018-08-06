//
//  LISuccessViewController.swift
//  Foodie
//
//  Created by Amy Zhao on 11/17/16.
//  Copyright © 2016 Pam. All rights reserved.
//

import UIKit

class LISuccessViewController: UIViewController {
    var vc = ViewController()
    
    @IBOutlet weak var welcomeString: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeString.text = "Hello, " + vc.prefs.string(forKey: "givenname")! + "!"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
