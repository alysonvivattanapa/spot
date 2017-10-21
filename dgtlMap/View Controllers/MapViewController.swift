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
             
                var images = [UIImage]()
                var animatedImage: UIImage!
                var test0 = UIImage(named: "Test000")
                var test1 = UIImage(named: "Test001")
                var test2 = UIImage(named: "Test002")
                var test3 = UIImage(named: "Test003")
                var test4 = UIImage(named: "Test004")
                var test5 = UIImage(named: "Test005")
                var test6 = UIImage(named: "Test006")
                var test7 = UIImage(named: "Test007")
                var test8 = UIImage(named: "Test008")
                var test9 = UIImage(named: "Test009")
                var test10 = UIImage(named: "Test010")
                var test11 = UIImage(named: "Test011")
                var test12 = UIImage(named: "Test012")
                var test13 = UIImage(named: "Test013")
                var test14 =  UIImage(named: "Test014")
                var test15 = UIImage(named: "Test015")
                var test16 = UIImage(named: "Test016")
                var test17 = UIImage(named: "Test017")
                var test18 = UIImage(named: "Test018")
                var test19 = UIImage(named: "Test019")
                var test20 = UIImage(named: "Test020")
                var test21 = UIImage(named: "Test021")
                var test22 = UIImage(named: "Test022")
                var test23 = UIImage(named: "Test023")
                
            
                images = [test0!, test1!, test2!, test3!, test4!, test5!, test6!, test7!, test8!, test9!, test10!, test11!, test12!, test13!, test14!, test15!, test16!, test17!, test18!, test19!, test20!, test21!, test22!, test23!]
                
                animatedImage = UIImage.animatedImage(with: images, duration: 1.0)
                
                let annotationNode = LocationAnnotationNode(location: location, image: animatedImage)
                
               
                
//            annotationNode.scaleRelativeToDistance = true
                
                let locationManager = CLLocationManager()
                if CLLocationManager.locationServicesEnabled() {
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    locationManager.startUpdatingLocation()
                }
                
                        if let myLocation = locationManager.location {
                            self.currentLat = myLocation.coordinate.latitude as NSNumber
                            self.currentLong = myLocation.coordinate.longitude as NSNumber
                
                            let distanceInMeters = location.distance(from: myLocation)
                            self.locationDistance = distanceInMeters
                
                            let roundedDistance = distanceInMeters.rounded()
                            
                            let rect = CGRect(x: 0, y: 0, width: 50, height: 50)
                            
                            let tbarLabelView = TBARLabelView(rect, text:"\(roundedDistance) m")
                            
                            let viewView = tbarLabelView.imageForView()
                            
                            let annotationNode2 = LocationAnnotationNode(location: location, image: viewView)
                            
                            
                            self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode2)
                        }
                
                
          
                
        self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
                
               
          
            }
        }

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




