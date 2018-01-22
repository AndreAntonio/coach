//
//  ProgressEntry.swift
//  coach
//
//  Created by Andre Faruolo on 21/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import Foundation
import UIKit

public class ProgressEntry {
    
    var progressImage : UIImage!
    var progressImageUrl : String
    var weekday : String
    var date : String!
    var month : String
    var day : String
    var milestone : String
    var currentWeight : String
    
    public init () {
        
        self.progressImageUrl = ""
        self.weekday = ""
        self.month = ""
        self.day = ""
        self.milestone = ""
        self.currentWeight = ""

    }

}
