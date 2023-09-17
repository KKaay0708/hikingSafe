//
//  BringViewController.swift
//  hikingSafe
//
//  Created by Kaitlyn Kwan on 8/3/23.
//

import UIKit

class BringViewController: UIViewController {

    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var essentialsLabel: UILabel!
    @IBOutlet weak var clothesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waterLabel.text = String(OnboardingViewController().showWater()) + " Liters"
        clothesLabel.text = OnboardingViewController().showClothes()
        essentialsLabel.text = "Pocketknife \nFirst Aid Kit \nExtra Clothing \nRain Gear \nWater \nFlashlight \nTrail Food \nFire Starters \nSun Protection \nMap and Compass\n"

    }

}
