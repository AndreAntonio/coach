//
//  ProgressEntryDetailViewController.swift
//  coach
//
//  Created by Andre Faruolo on 24/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ProgressEntryDetailViewController: UIViewController {
    
    @IBOutlet weak var weightLabelOutlet: UILabel!
    @IBOutlet weak var dateLabelOutlet: UILabel!
    @IBOutlet weak var progressImageOutlet: UIImageView!
    
    var progressEntry : ProgressEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.weightLabelOutlet.text = self.progressEntry.currentWeight + " Kg"
        self.dateLabelOutlet.text = self.progressEntry.weekday + "," + " " + self.progressEntry.dateDisplay
        
        var url = progressEntry.progressImageUrl
        var downloadUrl = URL(string: url)
        
        self.progressImageOutlet.sd_setImage(with: downloadUrl) { (image, error, cache, url) in
            
            print("imagem exibida")
            
        }
        

    }

    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "You are about to delete a Progress Entry", message:
            "This action is permanent. Are you sure you want to do this?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        let deleteButton = UIAlertAction(title: "Delete", style: .default, handler: { (action) -> Void in
            
          
            let userId = Auth.auth().currentUser?.uid as! String
            let dbRef = Database.database().reference().child("users").child(userId).child("progressEntries").child(self.progressEntry.id)
            
            dbRef.removeValue()
            
            let storage = Storage.storage().reference()
            let images = storage.child("images")
            let progressEntries = images.child("progress_entries")
            
            progressEntries.child(userId).child(self.progressEntry.id).delete(completion: nil)
            
            
            self.navigationController?.popViewController(animated: true)
            
        })
        
        alertController.addAction(deleteButton)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
}
