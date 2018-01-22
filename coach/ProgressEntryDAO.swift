//
//  ProgressEntryDAO.swift
//  coach
//
//  Created by Andre Faruolo on 21/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

public class ProgressEntryDAO {
    
    let database = Database.database().reference()
    let storage = Storage.storage().reference()
    
    public init(){}
    
    public func create ( progressEntry : ProgressEntry ) {
    
        let dateToString = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: dateToString as Date)
        
        let date =  Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        let weekDay = calendar.component(.weekday, from: date)
        
        var weekDayString : String = ""
        
        if weekDay == 1 {
            weekDayString = "Sunday"
        } else if weekDay == 2 {
            weekDayString = "Monday"
        } else if weekDay == 3 {
            weekDayString = "Tuesday"
        } else if weekDay == 4 {
            weekDayString = "Wednesday"
        } else if weekDay == 5 {
            weekDayString = "Thursday"
        } else if weekDay == 6 {
            weekDayString = "Friday"
        } else if weekDay == 7 {
            weekDayString = "Saturday"
        }
        
        progressEntry.date = dateString
        progressEntry.weekday = weekDayString
        
        var userId = Auth.auth().currentUser?.uid as! String

        let user = database.child("users").child(userId)
        
        var progressId = ("\(year)\(month)\(day)\(hour)\(minute)\(second)")
        

        let images = storage.child("images")
        let progressEntries = images.child("progress_entries")
        
        if let imageData = UIImageJPEGRepresentation(progressEntry.progressImage, 0.5) {
            
            progressEntries.child(String(userId)).child(progressId).putData(imageData, metadata: nil, completion: {(metadata, error) in
                
                if error == nil {
                    
                    progressEntry.progressImageUrl = (metadata?.downloadURL()?.absoluteString)!
                    
                    let progressEntryData = ["imageUrl" : progressEntry.progressImageUrl, "date" : progressEntry.date, "weekday" : progressEntry.weekday, "milestone" : progressEntry.milestone, "currentWeight" : progressEntry.currentWeight] as [String : Any]
                    user.child("progressEntries").child(progressId).setValue(progressEntryData)
                    
                } else {
                    
                    print(String(describing: error))
                    
                }
                
            })
            
        }
        
        
        
        
        
        
    }
    
    //    public func create( workout : Workout) {
    //
    //        var userId = Auth.auth().currentUser?.uid as! String
    //
    //
    //        let workouts = database.child("users").child(userId).child("workouts")
    //
    //        let workoutData = ["name" : workout.name, "description" : workout.description, "frequency": workout.frequency ] as [String : Any]
    //
    //        workouts.child(workout.name).setValue(workoutData)
    //
    //
    //
    //    }
    
    public func listAll(completion : @escaping ([Workout]?) -> Void) {
        
        var userId = Auth.auth().currentUser?.uid as! String
        var workoutsArray = [Workout]()
        
        let workouts = database.child("users").child(userId).child("workouts")
        
        workouts.observe(DataEventType.value) { (snapshot) in
            
            print(snapshot)
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let data = child.value as? NSDictionary
                
                let workoutName = child.key
                let workoutDescription = data!["description"] as! String
                let workoutFrequency = data!["frequency"] as! String
                
                let workoutInstance = Workout(name: workoutName, description: workoutDescription, frequency: workoutFrequency)
                
                workoutsArray.append(workoutInstance)
                
                
            }
            
            completion(workoutsArray)
            
        }
        
    }
    
    
    //    public func listAll(completion : @escaping ([User]?) -> Void) {
    //
    //        var usersArray = [User]()
    //
    //        let users = database.child("users")
    //
    //        users.observe(DataEventType.value) { (snapshot) in
    //
    //            print(snapshot)
    //
    //            for child in snapshot.children.allObjects as! [DataSnapshot] {
    //
    //                let data = child.value as? NSDictionary
    //
    //                let userId = child.key
    //                let userEmail = data!["email"] as! String
    //                let userName = data!["name"] as! String
    //                let userProfileImageUrl = data!["profileImageUrl"] as! String
    //
    //                let userInstance = User(uid: userId, fullName: userName, email: userEmail, profileImageUrl: userProfileImageUrl)
    //
    //                usersArray.append(userInstance)
    //
    //            }
    //            completion(usersArray)
    //        }
    //
    //    }
    
    //    public func listUserById( uId : String ) -> User{
    //
    //    }
    
    public func updateUser(){
        
    }
    
    public func delete(uid : String){
        
        
    }

    
}
