//
//  BaseAPIService.swift
//  dgtlMap
//
//  Created by Alyson Vivattanapa on 10/21/17.
//  Copyright © 2017 Alyson Vivattanapa. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

struct BaseAPIService {
    static let ref = Database.database().reference()
    
    static func getAllUsers(_ closure:@escaping ([User]) -> Void) {
    
        ref.observe(.value) { snapshot in

         print(snapshot)
            var arrayOfUserObjects = [User]()

            for user in snapshot.children {
                let oneUser = (user as! DataSnapshot).value as! NSDictionary
                
                let id = oneUser.value(forKey: "id") as! String
                
                let imageID = oneUser.value(forKey: "imageID") as! String
                
                let latitude = oneUser.value(forKey: "latitude") as! NSNumber
                
                let longitude = oneUser.value(forKey: "longitude") as! NSNumber
                
                let time = oneUser.value(forKey: "time") as! NSNumber
                
                let newUserObject = User(longitude: "\(longitude)", latitude: "\(latitude)", id: id, imageID: imageID, timeStamp: "\(time)")
                
                arrayOfUserObjects.append(newUserObject)
            }
            
            closure(arrayOfUserObjects)
        }
    }
    
    
    
    
}
