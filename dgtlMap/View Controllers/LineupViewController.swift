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
import FirebaseAuth

class LineupViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    var currentLong : NSNumber?
    var currentLat: NSNumber?
    
    var ref: DatabaseReference!
    

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var setStatusButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Status"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
    }

    @IBAction func setStatusButtonPressed(_ sender: UIButton) {
        setStatus()
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setStatus(){
    
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
            dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let stringDate = dateFormat.string(from: date)
            
            
            guard let id = UserDefaults.standard.value(forKey: "ID") else {return}
            
            
            let dict = ["longitude" : self.currentLong, "latitude" : self.currentLat, "id" : id, "imageID" : "11111", "time" : stringDate, "name" : self.textField.text ?? ""] as [String : Any]
            self.ref.child(String(describing: id)).setValue(dict, withCompletionBlock: { (error, data) in
                print("Saved data")
                let alert = UIAlertController(title: "Done!", message: "Your location is set!", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "Top!", style: UIAlertActionStyle.default) { (action) in
                    self.dismiss(animated: true, completion: {
                        
                    })
                }
                alert.addAction(ok)
                self.present(alert, animated: true) {
                }
            })

        }
    }
    
    
    
    
    
    
    

}
