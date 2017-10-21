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
    
    var test0: UIImage!
    
    var ref : DatabaseReference!

   lazy var locationDistance = Double()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Map"
        let refresh = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(getUsers))
        self.tabBarController?.navigationItem.rightBarButtonItem = refresh
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        getUsers()

    }
    
    @objc func getUsers() {
        BaseAPIService.getAllUsers { users in
            
            for user in users {

                let coordinate = CLLocationCoordinate2D(latitude: (user.latitude as NSString).doubleValue, longitude: (user.longitude as NSString).doubleValue)
                
                let location = CLLocation(coordinate: coordinate, altitude: 1)
                
                
                
                let image = #imageLiteral(resourceName: "main_00000")
                let annotationNode = LocationAnnotationNode(location: location, image: image)
                annotationNode.scaleRelativeToDistance = true
                self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
                
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
                    
//                    let dateFormat = DateFormatter()
                    //                    dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    //                    var dateString = ""
                    //                    if let date = dateFormat.date(from: user.timeStamp) {
                    //                         dateString = self.timeAgoSinceDate(date, currentDate: Date(), numericDates: false)
                    //                    }
                    let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
                    
                    let tbarLabelView = TBARLabelView(rect, text:"\(user.name)\n\(roundedDistance) m")
                    
                    let viewView = tbarLabelView.imageForView()
                    
                    let annotationNode2 = LocationAnnotationNode(location: location, image: viewView)
                    
                    self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode2)
                }
            }
        }
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

    func timeAgoSinceDate(_ date:Date,currentDate:Date, numericDates:Bool) -> String {
        let calendar = Calendar.current
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
    }
}




