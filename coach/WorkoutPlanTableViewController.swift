//
//  WorkoutsViewController.swift
//  coach
//
//  Created by Andre Faruolo on 02/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit
import Firebase

class WorkoutPlanTableViewController: UITableViewController
{
    
    var workouts : [Workout] = []
    
    @IBOutlet weak var newWorkoutBarButtonOutlet: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.clear
        
        let userId = Auth.auth().currentUser?.uid as! String
        let dbRef = Database.database().reference().child("users").child(userId).child("workouts")
        
        dbRef.observe(.value, with: {snapshot in
            
            var newItems : [Workout] = []
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let data = child.value as? NSDictionary
                
                let workoutName = data!["name"] as! String
                let workoutDescription = data!["description"] as! String
                
                let workoutInstance = Workout()
                
                workoutInstance.name = workoutName
                workoutInstance.description = workoutDescription
                
                newItems.append(workoutInstance)
                
            }
            
            self.workouts = newItems
            self.tableView.reloadData()
            
        })
       
    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newWorkoutBarButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nextVC = storyboard.instantiateViewController(withIdentifier: "newWorkoutPlanViewController") as! NewWorkoutPlanViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return workouts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutPlanTableViewCell", for: indexPath) as! WorkoutPlanTableViewCell
        
        cell.workoutNameLabelOutlet.text = workouts[indexPath.row].name
        cell.workoutDescriptionLabelOutlet.text = workouts[indexPath.row].description
        
        return cell
        
    }
    
    
}
