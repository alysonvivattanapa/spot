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
        
        let coordinate = CLLocationCoordinate2D(latitude: 52.134110, longitude: 5.034214)
        let location = CLLocation(coordinate: coordinate, altitude: 15)
        let image = UIImage(named: "pin")!
        
        let nodeLocationAndDistanceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 22))
//        let image = UIImage.imageWithLabel(label: nodeLocationAndDistanceLabel)
        
        let annotationNode = LocationAnnotationNode(location: location, image: image)
        
        //LocationAnnotationNode displays a 2d image within the world which always faces us
        
        
//        annotationNode.scaleRelativeToDistance = true
        //uncomment so size of annotation is relative to distance
        
//        let imageView = UIImageView.init(image: image)
        
      
//        nodeLocationAndDistanceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor)
//        view.addSubview(nodeLocationAndDistanceLabel)
      
        //should update label's frame to fit content
        
        let locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        if let myLocation = locationManager.location {
            currentLat = myLocation.coordinate.latitude as NSNumber
            currentLong = myLocation.coordinate.longitude as NSNumber
            
            let distanceInMeters = location.distance(from: myLocation)
            locationDistance = distanceInMeters
            
            nodeLocationAndDistanceLabel.text = "House behind me, distance from current location is \(distanceInMeters) m."
            nodeLocationAndDistanceLabel.sizeToFit()
            print(distanceInMeters)
            
            let roundedDistance = distanceInMeters.rounded()
            
            print("House behind me, distance from current location is \(roundedDistance) m.")
        }
        
        
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
       
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue: CLLocationCoordinate2D = manager.location?.coordinate {
        print("locations = \(locValue.latitude) \(locValue.longitude)")
            currentLat = locValue.latitude as NSNumber
            currentLong = locValue.longitude as NSNumber
        }
    }
 
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = view.bounds
        
    }

}




