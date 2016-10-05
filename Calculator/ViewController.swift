//
//  ViewController.swift
//  Calculator
//
//  Created by Peter Auerbacher on 29.04.16.
//  Copyright © 2016 Peter Auerbacher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    
    @IBOutlet fileprivate weak var display: UILabel!
    
    fileprivate  var userIsInTheMiddleOfTyping : Bool = false
    
    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
        let textCurrentlyInDisplay = display.text!
        display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    fileprivate var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    fileprivate var brain = CalculatorBrain()
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.perfomOperation(mathematicalSymbol)
        }
        displayValue =  brain.result
    }
}

