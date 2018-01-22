//
//  WorkoutsViewController.swift
//  coach
//
//  Created by Andre Faruolo on 02/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit

class WorkoutPlanTableViewController: UITableViewController
{
    
    var workouts : [Workout] = []
    
    @IBOutlet weak var newWorkoutBarButtonOutlet: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.clear
        
        var workout1 = Workout(name: "workoutA", description: "desc", frequency: "daily")
        var workout2 = Workout(name: "workoutB", description: "desc", frequency: "daily")
        
        workouts.append(workout1)
        workouts.append(workout2)
        
        var workoutDAO = WorkoutDAO()
    
        workoutDAO.listAll(completion: { workoutsArray in
            
            if let workoutsArray = workoutsArray {
                
                print("============================================")
                print(workoutsArray)
            }
        } )
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
        
        return cell
        
    }
    
    
}
