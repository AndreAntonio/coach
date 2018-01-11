//
//  progressOverviewViewController.swift
//  coach
//
//  Created by Andre Faruolo on 02/01/2018.
//  Copyright © 2018 com.br.andre.faruolo. All rights reserved.
//

import UIKit

class ProgressOverviewTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressTableViewCell", for: indexPath) as! ProgressTableViewCell
        
        var image : UIImage = UIImage(named: "camera-button")!
            
            cell.dateLabelOutlet.text = "dads"
            cell.currentWeightLabelOutlet.text = "dadsa"
            cell.weekDayLabelOutlet.text = "dsas"
            cell.progressBackgroundImage.image = image
            
            return cell
        
    }
    

 
}
