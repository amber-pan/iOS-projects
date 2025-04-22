//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Amber Pan on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet var HeightLabel: UILabel!
    @IBOutlet var WeightLabel: UILabel!
    @IBOutlet var HeightSlider: UISlider!
    @IBOutlet var WeightSlider: UISlider!
    
    var calculatorBrain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func HeightChanged(_ sender: UISlider) {

        print(String(format: "%.2f", sender.value))
        HeightLabel.text = String(format: "%.2f", sender.value)+"ft"
    }
    
    @IBAction func WeightChanged(_ sender: UISlider) {
        
          print(Int(sender.value))
        WeightLabel.text = String(Int(sender.value))+"lb"
    }
    
    @IBAction func CalculatePressed(_ sender: UIButton) {
           let height = HeightSlider.value
           let weight = WeightSlider.value

        calculatorBrain.calculateBMI(h: height, w: weight)
        
//        let secondVC = SecondViewController()
//        secondVC.bmiValue = String(format: "%.2f",bmi)
//
//        self.present(secondVC, animated: true, completion: nil)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ResultViewController

        destinationVC.bmiValue = calculatorBrain.getBMIValue()
   
        
    }
}


