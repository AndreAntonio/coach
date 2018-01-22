//
//  Workout.swift
//  coach
//
//  Created by Andre Faruolo on 12/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import Foundation

public class Workout {
    
    var id : String
    var name : String
    var description : String
    var frequency : String
    var exercises : [Exercise]?
 
    init() {
        
        self.id = ""
        self.name = ""
        self.description = ""
        self.frequency = ""
    }
    
    init ( name : String, description : String, frequency : String) {
        
        self.id = ""
        self.name = name
        self.description = description
        self.frequency = frequency
        
    }
    
    init( name : String, description : String, frequency : String, exercises : [Exercise]) {
        
        self.id = ""
        self.name = name
        self.description = description
        self.frequency = frequency
        self.exercises = exercises
        
    }
    
}
