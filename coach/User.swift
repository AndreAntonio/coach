
//  User.swift
//  coach
//  Created by Andre Faruolo on 02/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.


import Foundation
import FirebaseAuth
import UIKit

public class User {
    
    let uid: String!
    var fullName : String!
    var email : String!
    var profileImage : UIImage?
    var profileImageUrl : String?
    var workouts : [Workout]?
    
    init(){
        self.uid = ""
        self.fullName = ""
        self.email = ""
    }

    init(uid : String, fullName: String, email: String, profileImage : UIImage) {
        
        self.uid = uid
        self.fullName = fullName
        self.email = email
        self.profileImage = profileImage
        
    }
    
    init(uid : String, fullName: String, email: String, profileImageUrl : String) {
        
        self.uid = uid
        self.fullName = fullName
        self.email = email
        self.profileImageUrl = profileImageUrl
        
    }
    
}

