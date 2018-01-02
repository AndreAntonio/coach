//
//  SignInViewController.swift
//  coach
//
//  Created by Andre Faruolo on 01/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var usernameTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var signInButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var textFields = [usernameTextFieldOutlet, passwordTextFieldOutlet]
        self.setupTextFields(textFields: textFields as! [UITextField])

    }

    func setupTextFields(textFields: [UITextField]){
        
        for textField in textFields {
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = 2
            textField.frame.size.height = 45
        }
        
    }
    


}
