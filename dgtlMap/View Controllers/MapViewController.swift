//
//  MapViewController.swift
//  dgtlMap
//
//  Created by Alyson Vivattanapa on 10/5/17.
//  Copyright © 2017 Alyson Vivattanapa. All rights reserved.
//

import UIKit
import ARCL
import CoreLocation
import MapKit
import Firebase
import FirebaseDatabase

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var sceneLocationView = SceneLocationView()
    
    var currentLong : NSNumber?
    var currentLat : NSNumber?
    
    var ref : DatabaseReference!

   lazy var locationDistance = Double()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Map"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        
        BaseAPIService.getAllUsers { users in
            
            for user in users {
                
            print (user)
            
            let coordinate = CLLocationCoordinate2D(latitude: (user.latitude as NSString).doubleValue, longitude: (user.longitude as NSString).doubleValue)
                
            let location = CLLocation(coordinate: coordinate, altitude: 1)
                
            let image = UIImage(named: "pin")!
            
             let annotationNode = LocationAnnotationNode(location: location, image: image)
                
            annotationNode.scaleRelativeToDistance = true
        self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
            }
        }
       
        
        let locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
//        if let myLocation = locationManager.location {
//            currentLat = myLocation.coordinate.latitude as NSNumber
//            currentLong = myLocation.coordinate.longitude as NSNumber
//
//            let distanceInMeters = location.distance(from: myLocation)
//            locationDistance = distanceInMeters
//
//            nodeLocationAndDistanceLabel.text = "House behind me, distance from current location is \(distanceInMeters) m."
//            nodeLocationAndDistanceLabel.sizeToFit()
//            print(distanceInMeters)
//
//            let roundedDistance = distanceInMeters.rounded()
//
//            print("House behind me, distance from current location is \(roundedDistance) m.")
//        }
        
        
     //   sceneLocationView.addLocationNodeWithConfirmedLocati//on(locationNode: annotationNode)
//
//    }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue: CLLocationCoordinate2D = manager.location?.coordinate {
        print("locations = \(locValue.latitude) \(locValue.longitude)")
            currentLat = locValue.latitude as NSNumber
            currentLong = locValue.longitude as NSNumber
            
            /// HERE add the updated status with location change by grabbing last data? and then adding new latitude and longitude
        }
    }
 
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = view.bounds
    }

}




