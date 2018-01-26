//
//  ExerciseTableViewCell.swift
//  coach
//
//  Created by Andre Faruolo on 23/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var cardUIViewOutlet: UIView!
    @IBOutlet weak var exerciseNameLabelOutlet: UILabel!
    @IBOutlet weak var exerciseDescriptionLabelOutlet: UILabel!
    
    
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
