//
//  DataManager.swift
//  coach
//
//  Created by Andre Faruolo on 22/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import Foundation

public class DataManager {
    
    static let shared = DataManager()
    
    var exercises : [Exercise] = []
    var workoutFrequency : String = ""
    
    private init(){
        
    }
    
}
