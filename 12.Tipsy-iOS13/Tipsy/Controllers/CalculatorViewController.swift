//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    
    var peopleNumber = "0"
    var billValue = "0"
    var totalPerPerson = "0"
    var tipText = "0"
    
    var calculatorBrain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        tipText = sender.currentTitle!
        tipText = tipText.replacingOccurrences(of: "%", with: "")
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = Int(sender.value).description
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        billValue = billTextField.text!
        peopleNumber = splitNumberLabel.text!
    
        let billValue = billValue.replacingOccurrences(of: ",", with: ".")
        
        if billValue != "" {
            totalPerPerson = calculatorBrain.calculateSplitValue(peopleNumber: peopleNumber, tipPercentage: tipText, billValue: billValue)
        }
         
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "goToResult"{
               let destinationVC = segue.destination as! ResultsViewController //as! -> Downcasting
               destinationVC.peopleNumber = peopleNumber
               destinationVC.tipText = tipText
               destinationVC.totalPerPerson = totalPerPerson
           }
       }
    
    
}

