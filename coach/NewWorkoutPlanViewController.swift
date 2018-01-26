//
//  NewWorkoutPlanViewController.swift
//  coach
//
//  Created by Andre Faruolo on 15/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit

class NewWorkoutPlanViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
 
    var exercises : [Exercise] = []
    var setFrequency : String!
    
    @IBOutlet weak var exercisesTableViewOutlet: UITableView!
    @IBOutlet weak var workoutTitleTextFieldOutlet: UITextField!
    @IBOutlet weak var workoutDescriptionTextFieldOutlet: UITextField!
    @IBOutlet weak var setFrequencyTextFieldOutlet: UITextField!
    
    @IBOutlet weak var newExerciseButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setFrequencyTextFieldOutlet.text = ""
        DataManager.shared.workoutFrequency = ""

        
        self.exercises = []
        DataManager.shared.exercises = []
        
       var textFields = [workoutTitleTextFieldOutlet, workoutDescriptionTextFieldOutlet, setFrequencyTextFieldOutlet]
        self.setupTextFields(textFields: textFields as! [UITextField])
        
        self.exercisesTableViewOutlet.delegate = self
        self.exercisesTableViewOutlet.dataSource = self
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
       
        
        self.exercises = DataManager.shared.exercises
        print(exercises)
        
        print(DataManager.shared.workoutFrequency)
        
        self.setFrequencyTextFieldOutlet.text = DataManager.shared.workoutFrequency
        
      self.exercisesTableViewOutlet.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTextFields(textFields: [UITextField]){
        for textField in textFields {
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = 2
            textField.frame.size.height = 45
            textField.delegate = self
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = self.exercises[indexPath.row].name
        print(self.exercises[indexPath.row].name)
        
        return cell
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.setFrequencyTextFieldOutlet {
            
            self.view.endEditing(true)
            
       
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let nextVC = storyboard.instantiateViewController(withIdentifier: "setWorkoutFrequencyViewController") as! UIViewController
            
            self.navigationController?.pushViewController(nextVC, animated: true)
            self.view.endEditing(true)
            
        }
        
    }
    
    @IBAction func newExerciseButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "newExerciseViewController") as! NewExerciseViewController
        
        nextVC.exercises = self.exercises
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        var workoutDAO = WorkoutDAO()
        
        var workout : Workout = Workout()
        
        workout.name = self.workoutTitleTextFieldOutlet.text!
        workout.description = self.workoutDescriptionTextFieldOutlet.text!
        workout.frequency = self.setFrequencyTextFieldOutlet.text!
        workout.exercises = self.exercises
        
        workoutDAO.create(workout: workout)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    

}
