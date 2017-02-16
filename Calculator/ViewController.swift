//
//  ViewController.swift
//  Calculator
//
//  Created by Harry Pahwa on 2017-02-15.
//  Copyright © 2017 HarryPahwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calcDisplay: UILabel!
    
    var typing = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if typing{
            calcDisplay.text=calcDisplay.text!+sender.currentTitle!
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
    
    @IBAction func performOperation(_ sender: UIButton) {
    }
    
    
}

