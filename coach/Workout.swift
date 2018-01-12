//
//  Workout.swift
//  coach
//
//  Created by Andre Faruolo on 12/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import Foundation

public class Workout {
    
    var id : Int
    var name : String
    var description : String
    var frequency : String
    var exercises : [Exercise]?
 
    init() {
        self.id = 0
        self.name = ""
        self.description = ""
        self.frequency = ""
    }
    
    init ( id : Int, name : String, description : String, frequency : String) {
        
        self.id = id
        self.name = name
        self.description = description
        self.frequency = frequency
        
    }
    
    init(id : Int, name : String, description : String, frequency : String, exercises : [Exercise]) {
        
        self.id = id
        self.name = name
        self.description = description
        self.frequency = frequency
        self.exercises = exercises
        
    }
    
}
