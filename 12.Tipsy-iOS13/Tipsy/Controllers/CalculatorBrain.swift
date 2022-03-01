//
//  CalculatorBrain.swift
//  Tipsy
//
//  Created by Rafael Benjamin on 01/03/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    func calculateSplitValue(peopleNumber: String, tipPercentage: String, billValue: String) -> String {
        var tipPercentage = Float(tipPercentage)!
        tipPercentage = tipPercentage/100
        return  String(format:"%.2f", ( Float(billValue)! / Float(peopleNumber)! ) * (1 + tipPercentage ) )
    }
}
