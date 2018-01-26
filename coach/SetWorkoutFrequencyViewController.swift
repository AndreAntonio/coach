//
//  SetWorkoutFrequencyViewController.swift
//  coach
//
//  Created by Andre Faruolo on 18/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit

class SetWorkoutFrequencyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    var frequencyOptions = ["Daily", "Every Other Day", "Twice a Week", "Weekly"]
    
    var selectedFrequency = ""
    
    @IBOutlet weak var frequencyPickerViewOutlet: UIPickerView!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBOutlet weak var backgroundViewOutlet: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.endEditing(true)

        self.backgroundViewOutlet.layer.masksToBounds = true
        self.backgroundViewOutlet.layer.cornerRadius = 2
        
        self.backgroundViewOutlet.layer.shadowOpacity = 1
        self.backgroundViewOutlet.layer.shadowColor = UIColor.black.cgColor
        self.backgroundViewOutlet.layer.shadowOffset = CGSize.zero
        self.backgroundViewOutlet.layer.shadowRadius = 2
       
        self.frequencyPickerViewOutlet.dataSource = self
        self.frequencyPickerViewOutlet.delegate = self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.frequencyOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var rowTitle = frequencyOptions[row]
        return rowTitle
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        DataManager.shared.workoutFrequency = self.selectedFrequency
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedFrequency = frequencyOptions[row]
        
    }
    
    
    
    
}
