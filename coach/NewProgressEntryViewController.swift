//
//  NewProgressEntryViewController.swift
//  coach
//
//  Created by Andre Faruolo on 19/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit

class NewProgressEntryViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let progressEntryDAO = ProgressEntryDAO()
    
    @IBOutlet weak var weekDayOutlet: UILabel!
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var milestoneTextFieldOutlet: UITextField!
    @IBOutlet weak var currentWeightTextFieldOutlet: UITextField!
    
    @IBOutlet weak var addProgressImageButtonOutlet: UIButton!
    
    let picker = UIImagePickerController()
    var retrievedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureDate()
        
        self.milestoneTextFieldOutlet.text = ""
        self.currentWeightTextFieldOutlet.text = ""
        
        picker.delegate = self
        
        var textFields = [milestoneTextFieldOutlet, currentWeightTextFieldOutlet]
        self.setupTextFields(textFields:textFields as! [UITextField])
    }
    
    func setupTextFields(textFields: [UITextField]){
        for textField in textFields {
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = 2
            textField.frame.size.height = 45
            textField.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addProgressImageButtonTapped(_ sender: Any) {
        
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("é isso")
        
        self.retrievedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    
        var progressEntry = ProgressEntry()
        
        progressEntry.progressImage = retrievedImage
        progressEntry.currentWeight = self.currentWeightTextFieldOutlet.text!
        progressEntry.milestone = self.milestoneTextFieldOutlet.text!
        
        self.progressEntryDAO.create(progressEntry: progressEntry)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureDate(){
        
        let dateToString = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: dateToString as Date)
        
        let date =  Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        let weekDay = calendar.component(.weekday, from: date)
        
        var weekDayString : String = ""
        
        if weekDay == 1 {
            weekDayString = "Sunday"
        } else if weekDay == 2 {
            weekDayString = "Monday"
        } else if weekDay == 3 {
            weekDayString = "Tuesday"
        } else if weekDay == 4 {
            weekDayString = "Wednesday"
        } else if weekDay == 5 {
            weekDayString = "Thursday"
        } else if weekDay == 6 {
            weekDayString = "Friday"
        } else if weekDay == 7 {
            weekDayString = "Saturday"
        }
        
        var monthString : String = ""
        
        if month == 1 {
            monthString = "January"
        } else if month == 2 {
            monthString = "February"
        } else if month == 3 {
            monthString = "March"
        } else if month == 4 {
            monthString = "April"
        } else if month == 5 {
            monthString = "May"
        } else if month == 6 {
            monthString = "June"
        } else if month == 7 {
            monthString = "July"
        } else if month == 8 {
            monthString = "August"
        } else if month == 9 {
            monthString = "September"
        } else if month == 10 {
            monthString = "October"
        } else if month == 11 {
            monthString = "November"
        } else if month == 12 {
            monthString = "December"
        }
        
        var sufix : String = ""
        
        if (day == 1 || day == 21) || day == 31 {
            sufix = "st"
        } else if (day == 2 || day == 22) {
            sufix = "nd"
        } else if day == 3 || day == 23 {
            sufix = "rd"
        } else {
            sufix = "th"
        }

        
        self.weekDayOutlet.text = weekDayString
        self.dateOutlet.text = monthString + " \(day)" + "\(sufix)"
        
    }
    
 

}
