//
//  SecondViewController.swift
//  BMI Calculator
//
//  Created by Amber  Pan on 3/30/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

//build a view controller programatically
import UIKit
class SecondViewController: UIViewController {
    var bmiValue = "0.0"
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        view.backgroundColor = .red
        
        let label = UILabel()
        label.text = bmiValue
        label.textColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        view.addSubview(label)
        
        
    }
}
