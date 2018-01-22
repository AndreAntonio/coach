//
//  NewWorkoutPlanViewController.swift
//  coach
//
//  Created by Andre Faruolo on 15/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit

class NewWorkoutPlanViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
 
    var exercises : [Exercise]!
    var setFrequency : String!
    
    @IBOutlet weak var exercisesTableViewOutlet: UITableView!
    @IBOutlet weak var workoutTitleTextFieldOutlet: UITextField!
    @IBOutlet weak var workoutDescriptionTextFieldOutlet: UITextField!
    @IBOutlet weak var setFrequencyTextFieldOutlet: UITextField!
    
    @IBOutlet weak var newExerciseButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       var textFields = [workoutTitleTextFieldOutlet, workoutDescriptionTextFieldOutlet, setFrequencyTextFieldOutlet]
        self.setupTextFields(textFields: textFields as! [UITextField])
        
        self.exercisesTableViewOutlet.delegate = self
        self.exercisesTableViewOutlet.dataSource = self
        
       
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        return cell
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.setFrequencyTextFieldOutlet {
            
            print("é isso q nois tamo buscando")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let nextVC = storyboard.instantiateViewController(withIdentifier: "setWorkoutFrequencyViewController") as! UIViewController
            
            self.present(nextVC, animated: true, completion: nil)
            
            self.view.endEditing(true)
            
        }
        
    }
    
    @IBAction func newExerciseButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "newExerciseViewController") as! NewExerciseViewController
        
        nextVC.exercises = self.exercises
        
        self.present(nextVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    

}
