//
//  progressOverviewViewController.swift
//  coach
//
//  Created by Andre Faruolo on 02/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ProgressOverviewTableViewController: UITableViewController {
    
    var progressEntries: [ProgressEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.clear
        
        let userId = Auth.auth().currentUser?.uid as! String
        
        let dbRef = Database.database().reference().child("users").child(userId).child("progressEntries")
        
        dbRef.observe(.value, with: { snapshot in
            
            var newItems : [ProgressEntry] = []
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let data = child.value as? NSDictionary
                
                let currentWeight = data!["currentWeight"] as! String
                let weekday = data!["weekday"] as! String
                let imageUrl = data!["imageUrl"] as! String
                
                let entryInstance = ProgressEntry()
                
                entryInstance.progressImageUrl = imageUrl
                
                let url = URL(string: entryInstance.progressImageUrl)
                print(url)
                
                var imageView = UIImageView()
                
                imageView.sd_setImage(with: url, completed: { (image, error, cache, url) in
                    entryInstance.progressImage = image
                })
                entryInstance.currentWeight = currentWeight
                entryInstance.weekday = weekday
                
                newItems.append(entryInstance)
                
            }
            self.progressEntries = newItems
            self.tableView.reloadData()
            
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressEntries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressTableViewCell", for: indexPath) as! ProgressTableViewCell
        
            var image : UIImage = UIImage(named: "camera-button")!
            
            cell.dateLabelOutlet.text = "dads"
            cell.currentWeightLabelOutlet.text = self.progressEntries[indexPath.row].currentWeight
            cell.weekDayLabelOutlet.text = self.progressEntries[indexPath.row].weekday
        
            var url = progressEntries[indexPath.row].progressImageUrl
            var downloadUrl = URL(string: url)
        
        cell.progressBackgroundImage.sd_setImage(with: downloadUrl) { (image, error, cache, url) in
            
            print("imagem exibida")
            
        }
            
            return cell
        
    }
    
    @IBAction func newEntryButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nextVC = storyboard.instantiateViewController(withIdentifier: "newProgressEntryViewController") as! NewProgressEntryViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    

 
}
