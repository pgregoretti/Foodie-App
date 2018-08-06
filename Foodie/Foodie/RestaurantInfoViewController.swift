//
//  RestaurantInfoViewController.swift
//  Foodie
//
//  Created by Pamelons on 12/1/16.
//  Copyright © 2016 Pam. All rights reserved.
//

import UIKit

class RestaurantInfoViewController: UIViewController {
    var vc = ViewController()
    var restaurantName: String = "TEST NAME"
    var address: String = "TEST"
    var imageURL: URL? = nil
    var categories: String = "TEST"
    var distance: String = "TEST"
    var ratingImageURL: URL = (NSURL(string:"google.com") as URL?)!
    var bookmarks = [Business]()
    var business: Business?
    
    @IBOutlet weak var UIRestaurantName: UILabel!
    
    
    @IBOutlet weak var UIRatingsImage: UIImageView!
    
    //@IBOutlet weak var UIRestaurantImage: UIImageView!
    @IBOutlet weak var UIRestaurantImage: UIImageView!
    
    @IBOutlet weak var UICategories: UILabel!
    @IBOutlet weak var UIDistance: UILabel!
    @IBOutlet weak var UIAddress: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIRestaurantName.text = restaurantName
        UIAddress.text = address
        UICategories.text = categories
        UIDistance.text = distance
        
        
        if imageURL != nil {
            
        
            let data = NSData(contentsOf:ratingImageURL)
            let data2 = NSData(contentsOf:imageURL!)
            
            
            if data != nil {
                UIRatingsImage.image = UIImage(data:data! as Data)
                //UIRestaurantImage.image = UIImage(data:data2! as Data)
            }
            
            if data2 != nil {
                //UIRatingsImage.image = UIImage(data:data! as Data)
                UIRestaurantImage.image = UIImage(data:data2! as Data)
            }
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func bookmarkButtonClicked(_ sender: Any) {
//        var ans = vc.prefs.object(forKey: "bookmarks") as? [Business] ?? [Business]()
//        if ans == nil {
//            bookmarks.append(business!)
//            vc.prefs.set(bookmarks, forKey: "bookmarks")
//            print("hello 1")
//        } else {
//            ans.append(business!)
//            print(ans[0].name)
//            bookmarks = ans
//            vc.prefs.set(bookmarks, forKey: "bookmarks")
//            print("hello 2")
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
