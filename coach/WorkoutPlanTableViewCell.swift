//
//  WorkoutPlanTableViewCell.swift
//  coach
//
//  Created by Andre Faruolo on 11/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit

class WorkoutPlanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardUIViewOutlet: UIView!
    @IBOutlet weak var workoutNameLabelOutlet: UILabel!
    @IBOutlet weak var workoutDescriptionLabelOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cardUIViewOutlet.layer.masksToBounds = false
        self.cardUIViewOutlet.layer.shadowOpacity = 1
        self.cardUIViewOutlet.layer.shadowColor = UIColor.black.cgColor
        self.cardUIViewOutlet.layer.shadowOffset = CGSize.zero
        self.cardUIViewOutlet.layer.shadowRadius = 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
