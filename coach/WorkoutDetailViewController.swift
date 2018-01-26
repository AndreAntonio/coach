//
//  WorkoutDetailViewController.swift
//  coach
//
//  Created by Andre Faruolo on 23/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit
import Firebase

class WorkoutDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var workout = Workout()
    
    var exercises : [Exercise] = []

    @IBOutlet weak var workoutNameOutlet: UILabel!
    @IBOutlet weak var workoutDescriptionOutlet: UILabel!
    @IBOutlet weak var workoutFrequencyOutlet: UILabel!
    @IBOutlet weak var exerciseRoutineTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.exerciseRoutineTableView.separatorColor = UIColor.clear
        
        self.workoutNameOutlet.text = self.workout.name
        self.workoutDescriptionOutlet.text = self.workout.description
        self.workoutFrequencyOutlet.text = self.workout.frequency
        
        self.exerciseRoutineTableView.delegate = self
        self.exerciseRoutineTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let userId = Auth.auth().currentUser?.uid as! String
        let dbRef = Database.database().reference().child("users").child(userId).child("workouts")
        
        let exRef = dbRef.child(workout.id).child("exercises")
        
        exRef.observe(.value, with: {snapshot in
            
            var newItems : [Exercise] = []
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let data = child.value as? NSDictionary
                
                let exerciseName = data!["name"] as! String
                let numberOfSets = data!["sets"] as! String
                let numberOfReps = data!["reps"] as! String
                
                let exerciseInstance = Exercise()
                
                exerciseInstance.name = exerciseName
                exerciseInstance.sets = Int(numberOfSets)!
                exerciseInstance.reps = Int(numberOfReps)!
                
                newItems.append(exerciseInstance)
            }
            
            self.exercises = newItems
            self.exerciseRoutineTableView.reloadData()
            
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.exercises.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = self.exerciseRoutineTableView.dequeueReusableCell(withIdentifier: "exerciseTableViewCell", for: indexPath) as! ExerciseTableViewCell
        
        cell.exerciseNameLabelOutlet.text = self.exercises[indexPath.row].name
        
        var sets = String(self.exercises[indexPath.row].sets) + " sets of "
        var reps = String(self.exercises[indexPath.row].reps) + " reps"
        
        cell.exerciseDescriptionLabelOutlet.text = sets + reps
        
        return cell
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
       
        
        let alertController = UIAlertController(title: "You are about to delete a Workout", message:
            "This action is permanent. Are you sure you want to do this?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        let deleteButton = UIAlertAction(title: "Delete", style: .default, handler: { (action) -> Void in
            
           
            let userId = Auth.auth().currentUser?.uid as! String
            
            
            let dbRef = Database.database().reference().child("users").child(userId).child("workouts").child(self.workout.id)
            
            dbRef.removeValue()
            
            self.navigationController?.popViewController(animated: true)
            
        })
        
        alertController.addAction(deleteButton)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    

}
