//
//  RestaurantsNearbyViewController.swift
//  Foodie
//
//  Created by Pamelons on 11/20/16.
//  Copyright © 2016 Pam. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import CoreMotion
import Foundation

class RestaurantsNearbyViewController: UIViewController, UICollectionViewDataSource, CLLocationManagerDelegate, UICollectionViewDelegate {
    
    var locationManager: CLLocationManager?
    var latitude: String = ""
    var longitude: String = ""
    var businesses: [Business]?
    var bookmarks = [Business]()
    var canClick = false
    var wasShaken = false


    
    var collectionViewLayout: CustomImageFlowLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func unwindToNearby(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewLayout = CustomImageFlowLayout()
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.backgroundColor = UIColor.black

        // Do any additional setup after loading the view.
        
    }
    
    
    //MARK:- Prepare Segue
    
    /*

     */
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if businesses != nil
        {
        if segue.identifier == "seeRestaurantInfo" {
            let itemDetailViewController = segue.destination as! RestaurantInfoViewController
            
            if let selectedImageCell = sender as? UICollectionViewCell {
                let indexPath = collectionView.indexPath(for: selectedImageCell)
                let index = (indexPath! as IndexPath).row
                let selectedItem = businesses?[index]
                itemDetailViewController.restaurantName = (selectedItem?.name)!
                itemDetailViewController.address = (selectedItem?.address)!
                itemDetailViewController.categories = (selectedItem?.categories)!
                itemDetailViewController.distance = (selectedItem?.distance)!
                itemDetailViewController.imageURL = selectedItem?.imageURL
                itemDetailViewController.ratingImageURL = (selectedItem?.ratingImageURL)!
                itemDetailViewController.business = selectedItem
            }
            
            if wasShaken {
                let index = Int(arc4random_uniform(UInt32(businesses!.count)))
                let selectedItem = businesses?[index]
                itemDetailViewController.restaurantName = (selectedItem?.name)!
                itemDetailViewController.address = (selectedItem?.address)!
                itemDetailViewController.categories = (selectedItem?.categories)!
                itemDetailViewController.distance = (selectedItem?.distance)!
                itemDetailViewController.imageURL = selectedItem?.imageURL
                itemDetailViewController.ratingImageURL = (selectedItem?.ratingImageURL)!
                itemDetailViewController.business = selectedItem
                
                wasShaken = false
            }
            
        }
        }
        
    }

    override func motionEnded(_ motion: UIEventSubtype,
                              with: UIEvent?) {
        
        if motion == .motionShake{
//            let controller = UIAlertController(title: "Shake",
//                                               message: "The device is shaken",
//                                               preferredStyle: .alert)
//            
//            controller.addAction(UIAlertAction(title: "OK",
//                                               style: .default,
//                                               handler: nil))
//            
//            present(controller, animated: true, completion: nil)
            wasShaken = true
            self.performSegue(withIdentifier: "seeRestaurantInfo", sender: self)
            
        }
        
    }

    @IBAction func randomButtonPressed(_ sender: Any) {
                let alert: UIAlertController = UIAlertController(title: "Hint:", message: "To view a random restaurant, shake the device!", preferredStyle: .alert)
        
                let okAction: UIAlertAction = UIAlertAction(title: "Got it", style: .default, handler: nil)
                alert.addAction(okAction)
        
                self.present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {

            self.performSegue(withIdentifier: "seeRestaurantInfo", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var ans = 15
        if businesses != nil
        {
            ans = (businesses?.count)!
        }
        
        return ans
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        
        let imageName = "imageLoading"
        let index = (indexPath as NSIndexPath).row
        
        cell.imageView.image = UIImage(named: imageName)
        print("Loading images")
        
        
        if businesses != nil
        {
            print("Hello")
            var url = businesses?[index].imageURL
            var data = NSData(contentsOf : url!)
            var image = UIImage(data : data as! Data)
            cell.imageView.image = image
            
        }
        
        return cell
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Location code from example on Sherriff's GitHub
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count == 0{
            //handle error here
            return
        }
        
        let newLocation = locations[0]
        
        print("Latitude = \(newLocation.coordinate.latitude)")
        print("Longitude = \(newLocation.coordinate.longitude)")
        latitude = String(newLocation.coordinate.latitude)
        longitude = String(newLocation.coordinate.longitude)
        manager.stopUpdatingLocation()
        searchYelp(latitude: latitude, longitude: longitude)
        
        // could also allow updates to search by checking if difference between
        // global and local coordinate values stored differ by a certain amount
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error){
        print("Location manager failed with error = \(error)")
    }
    
    private func locationManager(manager: CLLocationManager,
                                 didChangeAuthorizationStatus status: CLAuthorizationStatus){
        
        print("The authorization status of location services is changed to: ", terminator: "")
        
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways:
            print("Authorized")
        case .authorizedWhenInUse:
            print("Authorized when in use")
        case .denied:
            print("Denied")
        case .notDetermined:
            print("Not determined")
        case .restricted:
            print("Restricted")
        }
        
    }
    
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: nil))
        
        present(controller, animated: true, completion: nil)
        
    }
    
    func createLocationManager(startImmediately: Bool){
        locationManager = CLLocationManager()
        if let manager = locationManager{
            print("Successfully created the location manager")
            manager.delegate = self
            manager.startUpdatingLocation()
//            if startImmediately{
//                manager.startUpdatingLocation()
//            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            case .authorizedAlways:
                /* Yes, always */
                createLocationManager(startImmediately: true)
            case .authorizedWhenInUse:
                /* Yes, only when our app is in use */
                createLocationManager(startImmediately: true)
            case .denied:
                /* No */
                displayAlertWithTitle(title: "Not Determined",
                                      message: "Location services are not allowed for this app")
            case .notDetermined:
                /* We don't know yet, we have to ask */
                createLocationManager(startImmediately: false)
                if let manager = self.locationManager{
                    manager.requestWhenInUseAuthorization()
                }
            case .restricted:
                /* Restrictions have been applied, we have no access
                 to location services */
                displayAlertWithTitle(title: "Restricted",
                                      message: "Location services are not allowed for this app")
            }
            
            
        } else {
            /* Location services are not enabled.
             Take appropriate action: for instance, prompt the
             user to enable the location services */
            print("Location services are not enabled")
        }
    }
    // end borrowed location code
    
    func searchYelp(latitude: String, longitude: String){
        
        Business.searchWithCoordinates(latitude: latitude, longitude: longitude, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            if let businesses = businesses {
                
                for business in businesses {
                    print("NAME: " + business.name!)
                    //print(business.imageURL)
                    
                }
                self.reloadGrid()
                
            }
            
            }
        )
        
        
    }

    func reloadGrid(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        print("reloading")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 3
        
        let itemWidth = (self.collectionView.frame.width - (numberOfColumns - 1)) / numberOfColumns
        return CGSize(width: itemWidth, height: itemWidth)
        
        
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
