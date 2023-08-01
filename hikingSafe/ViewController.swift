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
    
    @IBAction func didTapButton1(){
        guard let tm = storyboard?.instantiateViewController(identifier: "trailMain") as? SecondViewController else {
            print("Failed.")
            return
        }
        present(tm, animated: true)
    }
    
    
    

}

