//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Peter Auerbacher on 01.05.16.
//  Copyright © 2016 Peter Auerbacher. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    fileprivate var accumulator = 0.0
 
    func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    fileprivate var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(M_PI),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±": Operation.unaryOperation({ -$0 }),
        "×": Operation.binaryOperation({ $0 * $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "−": Operation.binaryOperation({ $0 - $1 }),
        "=": Operation.equals
    ]
    
    fileprivate enum Operation{
        case constant(Double)
        case unaryOperation((Double)-> Double)
        case binaryOperation((Double,Double)->Double)
        case equals
    }
    
    func perfomOperation(_ symbol: String){
        if let operation = operations[symbol]{
            switch operation{
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                accumulator = function(accumulator)
            case .binaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .equals:
                executePendingBinaryOperation()
            }
            
        }
    }
    
    fileprivate func executePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
        }
    }
    
    fileprivate var pending: PendingBinaryOperationInfo?
    
    fileprivate struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result : Double {
        get {
            return accumulator
        }
    }
    
}
