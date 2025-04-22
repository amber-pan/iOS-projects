//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Amber  Pan on 3/31/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

struct  CalculatorBrain {
    var bmi: Float? = 0.00
//
//    init() {
//        bmi = 0.0
//        bmiValue = "0.0"
//    }
    
    mutating func calculateBMI(h: Float, w: Float){
        let height = h*0.3048
        let weight = w*0.4536
        bmi = weight/(height * height)
       
    }
    
    func getBMIValue() -> String {
        if bmi != nil {
        let bmiValue = String(format: "%.2f", bmi!)
        return bmiValue
        }
        return "0.00"
}
}
