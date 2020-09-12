//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var percentage = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Let the CalculatorViewController respond to events associated with the text field
        billTextField.delegate = self
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        // Retract the keypad
        billTextField.endEditing(true)
        
        // Reset all three buttons to unselected
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Then select the button that is pressed
        sender.isSelected = true
        
        if sender.titleLabel?.text == "0%" {
            percentage = 0
        }
        else if sender.titleLabel?.text == "10%" {
            percentage = 0.1
        }
        else if sender.titleLabel?.text == "20%" {
            percentage = 0.2
        }
        else {
            percentage = 0
        }
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        billTextField.endEditing(true)
        
        splitNumberLabel.text = String(Int(sender.value))
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        print(percentage)
        print(Int(splitNumberLabel.text!)!)
        print(Float(billTextField.text!)!)
        
        performSegue(withIdentifier: "goToResults", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            // Get the new view controller using segue.destination.
            let destinationVC = segue.destination as! ResultsViewController
            
            let billTotal = Double(billTextField.text!)!
            let amountDue = billTotal * (Double(1)+percentage) / Double(splitNumberLabel.text!)!
            
            destinationVC.amountDue = String(format: "%.2f", amountDue)
            destinationVC.numPeople = Int(splitNumberLabel.text!)!
            destinationVC.tipRate = Int(percentage * 100)
        }
        
        
        
        
        // Pass the selected object to the new view controller.
    }
    
    
}

