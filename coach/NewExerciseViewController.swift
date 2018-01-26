//
//  NewExerciseViewController.swift
//  coach
//
//  Created by Andre Faruolo on 18/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit

class NewExerciseViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var exercises : [Exercise] = []
    
    @IBOutlet weak var backgroundViewOutlet: UIView!
    var presentWorkout : String!
    
    @IBOutlet weak var exerciseNameTextFieldOutlet: UITextField!
    @IBOutlet weak var setAmountPickerViewOutlet: UIPickerView!
    @IBOutlet weak var repAmountPickerViewOutlet: UIPickerView!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    
    var setsArray : [String] = ["1","2","3","4","5","6","7","8","9","10"]
    
    var repsArray : [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setAmountPickerViewOutlet.delegate = self
        self.setAmountPickerViewOutlet.dataSource = self
        self.repAmountPickerViewOutlet.dataSource = self
        self.repAmountPickerViewOutlet.delegate = self
        
        self.exerciseNameTextFieldOutlet.delegate = self
        self.exerciseNameTextFieldOutlet.layer.masksToBounds = true
        self.exerciseNameTextFieldOutlet.layer.cornerRadius = 2
        self.exerciseNameTextFieldOutlet.frame.size.height = 45

        self.backgroundViewOutlet.layer.masksToBounds = true
        self.backgroundViewOutlet.layer.cornerRadius = 2
        
        self.backgroundViewOutlet.layer.shadowOpacity = 1
        self.backgroundViewOutlet.layer.shadowColor = UIColor.black.cgColor
        self.backgroundViewOutlet.layer.shadowOffset = CGSize.zero
        self.backgroundViewOutlet.layer.shadowRadius = 2
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        var returnValue = Int()

        if pickerView == self.setAmountPickerViewOutlet {

        returnValue = 1

        } else if pickerView == self.repAmountPickerViewOutlet {

        returnValue = 1

        }

        return returnValue
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var returnValue = Int()
        
        if pickerView == self.setAmountPickerViewOutlet {
            
            returnValue = self.setsArray.count
            
        } else if pickerView == self.repAmountPickerViewOutlet {
            
            returnValue = self.repsArray.count
            
        }
        return returnValue
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var returnValue: String = ""
        
        if pickerView == self.setAmountPickerViewOutlet {
            
            returnValue = self.setsArray[row]
            
        } else if pickerView == self.repAmountPickerViewOutlet {
            
            returnValue = self.repsArray[row]
            
        }
        return returnValue
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        var exercise = Exercise()
        
        exercise.name = self.exerciseNameTextFieldOutlet.text!
        exercise.reps = self.repAmountPickerViewOutlet.selectedRow(inComponent: 0) as Int
        exercise.sets = self.setAmountPickerViewOutlet.selectedRow(inComponent: 0) as Int
        
        self.exercises.append(exercise)
        DataManager.shared.exercises = self.exercises
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

   
    
    
    
    

}
