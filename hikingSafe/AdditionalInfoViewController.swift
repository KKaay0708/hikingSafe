//
//  AdditionalInfoViewController.swift
//  hikingSafe
//
//  Created by Kaitlyn Kwan on 8/3/23.
//

import UIKit

class AdditionalInfoViewController: UIViewController {
    
    static var type: String = "Plants"

    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var image0: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var image4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label0.tag = 1
        label1.tag = 2
        label2.tag = 3
        label3.tag = 4
        label4.tag = 5
        image0.tag = 6
        image1.tag = 7
        image2.tag = 8
        image3.tag = 9
        image4.tag = 10
        
        let defaults = UserDefaults.standard
        for i in 0...9 {
            if let labelName = self.view.viewWithTag(i+1) as? UILabel {
                if(AdditionalInfoViewController.type == "Animals"){
                    InfoController.getAnimalDatabaseInfo(onSuccess: {
                        labelName.text = defaults.string(forKey: "animal\(i)LabelKey")
                    }) { (error) in
                        print("error.")
                    }
                }
                if(AdditionalInfoViewController.type == "Plants"){
                    InfoController.getPlantDatabaseInfo(onSuccess: {
                        labelName.text = defaults.string(forKey: "plant\(i)LabelKey")
                    }) { (error) in
                        print("error.")
                    }
                }
            }
            if let imageName = self.view.viewWithTag(i+1) as? UIImageView{
                if(AdditionalInfoViewController.type == "Animals"){
                    InfoController.getAnimalDatabaseInfo(onSuccess: {
                        let dangerOrSafe = defaults.bool(forKey: "animal\(i-5)DangerKey")
                        if (dangerOrSafe) {
                            imageName.image = #imageLiteral(resourceName: "danger")
                        } else {
                            imageName.image = #imageLiteral(resourceName: "safe")
                        }
                    }) { (error) in
                        print("error.")
                    }
                }
                if(AdditionalInfoViewController.type == "Plants"){
                    InfoController.getPlantDatabaseInfo(onSuccess: {
                        let dangerOrSafe = defaults.bool(forKey: "plant\(i-5)DangerKey")
                        if (dangerOrSafe) {
                            imageName.image = #imageLiteral(resourceName: "danger")
                        } else {
                            imageName.image = #imageLiteral(resourceName: "safe")
                        }
                    }) { (error) in
                        print("error.")
                    }
                }
            }
        }
    }
}
