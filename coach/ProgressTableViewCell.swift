//
//  ProgressTableViewCell.swift
//  coach
//
//  Created by Andre Faruolo on 08/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var progressBackgroundImage: UIImageView!
    @IBOutlet weak var weekDayLabelOutlet: UILabel!
    @IBOutlet weak var dateLabelOutlet: UILabel!
    @IBOutlet weak var currentWeightLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.progressBackgroundImage.layer.masksToBounds = false
        self.progressBackgroundImage.layer.shadowOpacity = 1
        self.progressBackgroundImage.layer.shadowColor = UIColor.black.cgColor
        self.progressBackgroundImage.layer.shadowOffset = CGSize.zero
        self.progressBackgroundImage.layer.shadowRadius = 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
