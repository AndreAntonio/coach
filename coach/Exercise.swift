//
//  Exercise.swift
//  coach
//
//  Created by Andre Faruolo on 12/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import Foundation

public class Exercise {
    
    var name : String
    var sets : Int
    var reps : Int
    
    init() {
        
        self.name = ""
        self.sets = 0
        self.reps = 0
        
    }
    
    init(name : String, sets : Int, reps : Int) {
        
        self.name = name
        self.sets = sets
        self.reps = reps
        
    }
    
}
