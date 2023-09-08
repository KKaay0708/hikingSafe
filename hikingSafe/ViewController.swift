//
//  ViewController.swift
//  hikingSafe
//
//  Created by Kaitlyn Kwan on 7/31/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func trail0Clicked(_ sender: Any) {
        OnboardingViewController.pagee = 0
    }
    
    @IBAction func trail1Clicked(_ sender: Any) {
        OnboardingViewController.pagee = 1
    }
    
    @IBAction func trail2Clicked(_ sender: Any) {
        OnboardingViewController.pagee = 2

    }
    
    @IBAction func trail3Clicked(_ sender: Any) {
        OnboardingViewController.pagee = 3

    }
    
    @IBAction func trail4Clicked(_ sender: Any) {
        OnboardingViewController.pagee = 4

    }
    
}

