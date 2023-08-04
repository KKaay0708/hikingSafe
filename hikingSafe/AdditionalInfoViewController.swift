//
//  AdditionalInfoViewController.swift
//  hikingSafe
//
//  Created by Kaitlyn Kwan on 8/3/23.
//

import UIKit

class AdditionalInfoViewController: UIViewController {
    
    
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
        
        label0.tag = 0
        label1.tag = 1
        label2.tag = 2
        label3.tag = 3
        label4.tag = 4
        image0.tag = 5
        image1.tag = 6
        image2.tag = 7
        image3.tag = 8
        image4.tag = 9
        
        let defaults = UserDefaults.standard
        
        for i in 0...4 {
            if let labelName = self.view.viewWithTag(i) as? UILabel {
                InfoController.getDatabaseInfo(onSuccess: {
                    labelName.text = defaults.string(forKey: "animal\(i)LabelKey")
                    for j in 5...9{
                        if let imageName = self.view.viewWithTag(j) as? UIImageView {
                            let dangerOrSafe = defaults.string(forKey: "animal\(i)DangerKey")
                            if (dangerOrSafe == "true") {
                                imageName.image = #imageLiteral(resourceName: "danger")
                            } else {
                                imageName.image = #imageLiteral(resourceName: "safe")
                            }
                            
                        }
                    }
                }) { (error) in
                    print("error.")
                }
            }
        }
    }
}
