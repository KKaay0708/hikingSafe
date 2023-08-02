//
//  ViewController.swift
//  hikingSafe
//
//  Created by Kaitlyn Kwan on 7/31/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pageControl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 10, y: view.frame.size.height-100, width: view.frame.width-20, height: 70)
    }

}

