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
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Graduate-Regular", size: 16)!, NSAttributedStringKey.foregroundColor : UIColor.white]
                
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
            
            self.userInfoTableViewOutlet.reloadData()
            
        }
        
        
        
        
        
//        userDAO.listAll(completion: { usersArray in
//            if let usersArray = usersArray {print("============================================")
//                print(usersArray)
//            }
//        } )
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userInfoDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
    
        cell.textLabel?.text = self.userInfoTitle[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.text = self.userInfoDetail[indexPath.row]
        cell.detailTextLabel?.textColor = UIColor.white

    
        return cell
        
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        
       let auth = Auth.auth()
        do {
            try auth.signOut()
            
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var nextVC = storyboard.instantiateViewController(withIdentifier: "signInViewController") as! SignInViewController
            self.present(nextVC, animated: true, completion: nil)
            
        } catch let signOutError as NSError {
            print("error while signing out")
        }
        
        
        
    }
    
    
    
    
    
}
