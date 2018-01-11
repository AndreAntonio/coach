//
//  UserSettingsViewController.swift
//  coach
//
//  Created by Andre Faruolo on 02/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit
import Firebase

class UserSettingsViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabelOutlet: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDAO = UserDAO()
        
        userDAO.listAll(completion: { usersArray in
            
            if let usersArray = usersArray {
                
                print("============================================")
                print(usersArray)
                
            }
            
        } )
        
        
    }
    
    
    
}
