//
//  WorkoutDAO.swift
//  coach
//
//  Created by Andre Faruolo on 12/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

public class WorkoutDAO {
    
    let database = Database.database().reference()
    let storage = Storage.storage().reference()
    
    public init(){}
    
    
    public func create( workout : Workout) {
        
        var userId = Auth.auth().currentUser?.uid as! String
        
        workout.id = 01
        workout.name = "Workout A"
        workout.description = "Biceps"
        workout.frequency = "Daily"
        
        let workouts = database.child("users").child(userId).child("workouts")
        
        let workoutData = ["id" : workout.id, "name" : workout.name, "description" : workout.description, "frequency": workout.frequency ] as [String : Any]
        
        workouts.child(workout.name).setValue(workoutData)
        
        
        
    }
    
    
//    public func create(user : User){
//
//        let users = database.child("users")
//        let images = storage.child("images")
//        let profile_pics = images.child("profile_pics")
//
//        if let imageData = UIImageJPEGRepresentation(user.profileImage!, 0.5){
//
//            profile_pics.child(String(user.uid)).putData(imageData, metadata: nil, completion: { (metaData, error) in
//
//                if error == nil {
//
//                    user.profileImageUrl = (metaData?.downloadURL()?.absoluteString)!
//                    let userData = ["name" : user.fullName, "email" : user.email, "profileImageUrl" : user.profileImageUrl]
//
//                    users.child(String(user.uid)).setValue(userData)
//
//                } else {
//                    print(String(describing: error))
//                }
//            })
//
//        }
//
//    }
    
    public func listAll(completion : @escaping ([User]?) -> Void) {
        
        var usersArray = [User]()
        
        let users = database.child("users")
        
        users.observe(DataEventType.value) { (snapshot) in
            
            print(snapshot)
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let data = child.value as? NSDictionary
                
                let userId = child.key
                let userEmail = data!["email"] as! String
                let userName = data!["name"] as! String
                let userProfileImageUrl = data!["profileImageUrl"] as! String
                
                let userInstance = User(uid: userId, fullName: userName, email: userEmail, profileImageUrl: userProfileImageUrl)
                
                usersArray.append(userInstance)
                
            }
            completion(usersArray)
        }
        
    }
    
    public func listUserById( uId : String ) -> User{
        
        //gotta go through this code later on.
        
        var userReturn = User()
        
        let users = database.child("users")
        
        users.observe(DataEventType.value) { (snapshot) in
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let data = snapshot.value as? NSDictionary
                
                let userId = child.key
                let userEmail = data!["email"] as! String
                let userName = data!["name"] as! String
                let userProfileImageUrl = data?["profileImageUrl"] as! String
                
                let userInstance = User(uid: userId, fullName: userName, email: userEmail, profileImageUrl: userProfileImageUrl)
                
                if userInstance.uid == uId {
                    userReturn = userInstance
                }
                
            }
        }
        
        return userReturn
    }
    
    public func updateUser(){
        
    }
    
    public func delete(uid : String){
        
        
    }
    
}

