//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Harry Pahwa on 2017-02-15.
//  Copyright © 2017 HarryPahwa. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    private var retVal: Double?
    
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> = [
        
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±": Operation.unaryOperation({-$0}),
        "÷": Operation.binaryOperation({$0/$1}),
        "+": Operation.binaryOperation({$0+$1}),
        "-": Operation.binaryOperation({$0-$1}),
        "×": Operation.binaryOperation({$0*$1}),
        "=": Operation.equals
        
    ]
    
    
    mutating func setOperand(_ operand: Double){
        retVal=operand
    }
    
    var result: Double?{
        get{
            return retVal
        }
    }
    
    private struct PendingBinaryOperation{
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        mutating func perform(with secondOperand: Double) -> Double{
            return function(firstOperand, secondOperand)
        }
    }
    
    private var opSelected : PendingBinaryOperation?
    
    mutating func performFunction(_ symbol: String){
        if let choice = operations[symbol] {
            switch choice{
            case .constant(let value):
                retVal = value
            case .unaryOperation(let function):
                if retVal != nil {
                    retVal = function(retVal!)
                }
            case .binaryOperation(let function):
                opSelected=PendingBinaryOperation(function: function, firstOperand: retVal!)
                retVal=nil
                
            case .equals:
                if opSelected != nil && retVal != nil {
                    retVal=opSelected!.perform(with: retVal!)
                    opSelected=nil
                }
                
            }
            
        }
    }
}
