//
//  ExerciseDAO.swift
//  coach
//
//  Created by Andre Faruolo on 12/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

public class ExerciseDAO {
    
    let database = Database.database().reference()
    let storage = Storage.storage().reference()
    
    public init(){}
    
    public func create ( exercise : Exercise, workout : Workout) {
        
        var userId = Auth.auth().currentUser?.uid as! String
        
        let exercises = database.child("users").child(userId).child("workouts").child(workout.name).child("exercises")
        
        let exerciseData = ["name" : exercise.name, "reps" : String(exercise.reps), "sets" : String(exercise.sets)] as [String : Any]
        
        exercises.child(exercise.name).setValue(exerciseData)

        
    }
    
//    public func create( workout : Workout) {
//
//        var userId = Auth.auth().currentUser?.uid as! String
//
//        wo.name = "Workout A"
//        workout.description = "Biceps"
//        workout.frequency = "Daily"
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


