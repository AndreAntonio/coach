//
//  UserSettingsViewController.swift
//  coach
//
//  Created by Andre Faruolo on 02/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class UserSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var userInfoTableViewOutlet: UITableView!
    @IBOutlet weak var userImageOutlet: UIImageView!
    @IBOutlet weak var userNameOutlet: UILabel!
    var currentUser = User()
    
    var userInfoTitle = ["Email"]
    var userInfoDetail = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.userInfoTableViewOutlet.delegate = self
        self.userInfoTableViewOutlet.dataSource = self
        self.userNameOutlet.text = ""
        self.userImageOutlet.contentMode = .scaleAspectFill
        self.userImageOutlet.layer.masksToBounds = true
        self.userImageOutlet.layer.cornerRadius = self.userImageOutlet.bounds.width/2
        
        let uid = Auth.auth().currentUser?.uid as! String
        let database = Database.database().reference()
        let currentUser = database.child("users").child(uid)
        
        currentUser.observeSingleEvent(of: .value) { (snapshot) in
            
            let data = snapshot.value as? NSDictionary
            self.currentUser.fullName = data?["name"] as! String
            self.currentUser.email = data?["email"] as! String
            
            self.userInfoDetail.append(self.currentUser.email)
            self.currentUser.profileImageUrl = data?["profileImageUrl"] as! String
            self.userNameOutlet.text = self.currentUser.fullName.uppercased()
            let url = URL(string: self.currentUser.profileImageUrl!)
            print(url)

            self.userImageOutlet.sd_setImage(with: url, completed: { (image, error, cache, url) in
                print("imagem exibida")
            })
            
        }
        
        
        
        
        
//        userDAO.listAll(completion: { usersArray in
//            if let usersArray = usersArray {print("============================================")
//                print(usersArray)
//            }
//        } )
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userInfoTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
    
        cell.textLabel?.text = self.userInfoTitle[indexPath.row]

    
        return cell
        
    }
    
    
}
