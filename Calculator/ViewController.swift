//
//  ViewController.swift
//  Calculator
//
//  Created by Harry Pahwa on 2017-02-15.
//  Copyright © 2017 HarryPahwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var intermediateCalcs: UILabel!
    @IBOutlet weak var decimalButton: UIButton!
    @IBOutlet weak var calcDisplay: UILabel!
    
    var typing = false
    var decimal = false
    var equals=false
    
    @IBAction func clearButton(_ sender: UIButton) {
        
        typing=false
        decimal=false
        decimalButton!.isEnabled=true
        equals=false
        intermediateCalcs.text=""
        calcDisplay.text=String(0)
        brain.clear()
    }
    
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
        if equals==true {
            intermediateCalcs.text=" "
            equals=false
        }
        textValue=textValue+sender.currentTitle!
    }
    
    var dispValue : Double {
        get {
            return Double(calcDisplay.text!)!
        }
        set {
            calcDisplay.text=String(newValue)
        }
    }
    
    var textValue : String {
        get {
            return intermediateCalcs.text!
        }
        set {
            
            intermediateCalcs.text=String(newValue)
        }
    }
    
    var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        decimal=false
        decimalButton!.isEnabled=true
        if equals==true {
            intermediateCalcs.text=" "
            equals=false
        }
        textValue=textValue+" "+sender.currentTitle!+" "
        if typing{
            brain.setOperand(dispValue)
            typing = false
        }
        if let symbol=sender.currentTitle{
            brain.performFunction(symbol)
        }
        if let result=brain.result {
            dispValue=result
            if sender.currentTitle! == "="{
                
                textValue=textValue+" "+String(result)
                equals=true
            }
        }
        
    }
    
    
}

