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
    
    var id : String!
    var progressImage : UIImage!
    var progressImageUrl : String
    var weekday : String
    var date : String!
    var dateDisplay : String!
    var milestone : String
    var currentWeight : String
    
    public init () {
        
        self.id = ""
        self.progressImageUrl = ""
        self.weekday = ""
        self.dateDisplay = ""
        self.milestone = ""
        self.currentWeight = ""

    }

}

