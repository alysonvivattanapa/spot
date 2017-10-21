//
//  LineupViewController.swift
//  dgtlMap
//
//  Created by Alyson Vivattanapa on 10/13/17.
//  Copyright © 2017 Alyson Vivattanapa. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Firebase
import FirebaseDatabase

class LineupViewController: UIViewController, CLLocationManagerDelegate {
    
    var currentLong : NSNumber?
    var currentLat: NSNumber?
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var setStatusButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Status"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    @IBAction func setStatusButtonPressed(_ sender: UIButton) {
        
        setStatus()
        
    }
    
    func setStatus(){
//    func setStatus(_ status: User) {
    
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        self.ref = Database.database().reference()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways ){
            
            let currentLocation = locManager.location
            
            self.currentLat = currentLocation!.coordinate.latitude as NSNumber
            self.currentLong = currentLocation!.coordinate.longitude as NSNumber
            
            let date = Date()
            let dateFormat = DateFormatter()
            let stringDate = dateFormat.string(from: date)
            let id = NSUUID().uuidString

        
        
            let dict = ["longitude" : self.currentLong, "latitude" : self.currentLat, "id" : "12345", "imageID" : "11111", "time" : stringDate] as [String : Any]
        self.ref.child(id).setValue(dict, withCompletionBlock: { (error, data) in
            print("yay")
        })

        }
    }
    
    
    
    
    
    
    

}
