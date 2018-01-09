//
//  SignUpViewController.swift
//  coach
//
//  Created by Andre Faruolo on 02/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profilePicTextOutlet: UILabel!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    @IBOutlet weak var userImageButtonOutlet: UIButton!
    
    let picker = UIImagePickerController()
    var retrievedImage: UIImage!
    
    @IBOutlet weak var fullNameTextFieldOutlet: UITextField!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOutlet: UITextField!
    @IBOutlet weak var confirmPasswordTextFieldOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        
        self.userImageButtonOutlet.layer.masksToBounds = true
        self.userImageButtonOutlet.layer.cornerRadius = userImageButtonOutlet.bounds.height/2
        
        var textFields = [fullNameTextFieldOutlet, emailTextFieldOutlet, passwordTextFieldOutlet, confirmPasswordTextFieldOutlet]
        self.setupTextFields(textFields: textFields as! [UITextField])
      
    }

    func setupTextFields(textFields: [UITextField]){
        for textField in textFields {
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = 2
            textField.frame.size.height = 45
            textField.delegate = self
        }
    }
    
    
    @IBAction func changeUserImageButtonTapped(_ sender: Any) {
     
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.retrievedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        userImageButtonOutlet.contentMode = .scaleAspectFit //3
        userImageButtonOutlet.setBackgroundImage(self.retrievedImage, for: .normal)
        self.profilePicTextOutlet.text = "CHANGE PROFILE PICTURE"
        dismiss(animated:true, completion: nil) //5
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if let email = self.emailTextFieldOutlet.text {
            if let password = self.passwordTextFieldOutlet.text {
                if let fullName = self.fullNameTextFieldOutlet.text {
                    if let image = self.retrievedImage {
                        
                        if self.passwordTextFieldOutlet.text == self.confirmPasswordTextFieldOutlet.text {
                            
                           
                            
                            let user = Auth.auth()
                            user.createUser(withEmail: email, password: password) { (user, error) in
                                if error ==  nil {
                                    
                                    self.signUpButtonOutlet.isEnabled = false
                                    self.signUpButtonOutlet.setTitle("CREATING USER", for: .normal)
                                    
                                    let storage = Storage.storage().reference()
                                    let images = storage.child("images")
                                    let profile_pics = images.child("profile_pics")
                                    
                                    let database = Database.database().reference()
                                    let users = database.child("users")
                                    
                                    let  userData = ["name" : self.fullNameTextFieldOutlet.text, "email" : self.emailTextFieldOutlet.text]
                                    
                                    users.child(String(describing: user!.uid)).setValue(userData)
                                    
                                    if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                                        
                                        profile_pics.child(String(user!.uid)).putData(imageData, metadata: nil, completion: { (metaData, error) in
                                            
                                            if error == nil {
                                                print("deu bom")
                                            } else {
                                                print(String(describing: error))
                                            }
                                        })
                                        
                                    }
                                    
                                    print("User succesfully created" +  String( describing: user!.email))
                                    
                                }else{
                                    var alert = UIAlertController(title: "Error creating new user.", message: String(describing: error), preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                                
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let nextVC = storyboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                                self.present(nextVC, animated: true, completion: nil)
                                
                            }
                            
                        } else if passwordTextFieldOutlet.text != confirmPasswordTextFieldOutlet.text {
                            
                            var alert = UIAlertController(title: "Passwords are not a match", message: "Please, revise both password fields.", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
