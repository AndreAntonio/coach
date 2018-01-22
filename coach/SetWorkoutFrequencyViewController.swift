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
    
    @IBOutlet weak var frequencyPickerViewOutlet: UIPickerView!
    @IBOutlet weak var cancelButtonOutlet: UIButton!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBOutlet weak var backgroundViewOutlet: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundViewOutlet.layer.masksToBounds = true
        self.backgroundViewOutlet.layer.cornerRadius = 2
       
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
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
}
