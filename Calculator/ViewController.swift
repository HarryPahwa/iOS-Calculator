//
//  ViewController.swift
//  Calculator
//
//  Created by Harry Pahwa on 2017-02-15.
//  Copyright © 2017 HarryPahwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var decimalButton: UIButton!
    @IBOutlet weak var calcDisplay: UILabel!
    
    var typing = false
    var decimal = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if typing{
            if sender.currentTitle! != "." {
                calcDisplay.text=calcDisplay.text!+sender.currentTitle!
            } else if sender.currentTitle! == "." && !decimal {
                calcDisplay.text=calcDisplay.text!+sender.currentTitle!
                decimal=true
                decimalButton!.isEnabled=false
            }
        }
        else {
            calcDisplay.text=sender.currentTitle!
            typing=true
        }
    }
    
    var dispValue : Double {
        get {
            return Double(calcDisplay.text!)!
        }
        set {
            calcDisplay.text=String(newValue)
        }
    }
    
    var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        decimal=false
        decimalButton!.isEnabled=true
        if typing{
            brain.setOperand(dispValue)
            typing = false
        }
        if let symbol=sender.currentTitle{
            brain.performFunction(symbol)
        }
        if let result=brain.result {
            dispValue=result
        }
    }
    
    
}

