//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Rafael Benjamin on 28/02/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    mutating func calculateBmi(height: Float, weight: Float){
        let bmiValue = weight / pow(height,2)
        //Display of #colorLiretal pallete here in xcode is bugged =/
        if bmiValue < 18.5 {
            let color = #colorLiteral(red: 0.3844064772, green: 0.8040315509, blue: 0.9943324924, alpha: 1)
            bmi = BMI(value: bmiValue,
                      advice: "Eat more pies",
                      color: color)
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle", color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1) )
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies", color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) )
        }
        
        
    }
    
    func getBmiValue() -> String{
        return String(format:"%.1f", bmi?.value ?? 0.0 )
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "Calculation Necessary"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
}
