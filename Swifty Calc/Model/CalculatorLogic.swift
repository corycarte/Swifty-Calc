//
//  CalculatorLogic.swift
//  Swifty Calc
//
//  Created by Cory Carte on 7/20/22.
//

import Foundation


struct CalculatorLogic {
    private var number: Double?
        
        // preferred tuple creation method
        // give names to tuple members
        private var intermediateCalc: (n1: Double, operation: String)?
        
        mutating func setNumber(_ input: Double) {
            self.number = input
        }
        
        private func performTwoNumberCalculation(n2: Double) -> Double? {
            if let n1 = intermediateCalc?.n1, let op = intermediateCalc?.operation {
                switch(op) {
                case "+":
                    return n1 + n2
                case "-":
                    return n1 - n2
                case "×":
                    return n1 * n2
                case "÷":
                    return n1 / n2
                default:
                    fatalError("Unknown Operation occured: \(op)")
                }
            }
            
            return nil
        }
            
        mutating func calculate(_ symbol: String) -> Double? {
            if let value = self.number {
                switch(symbol) {
                case "+/-":
                    return value * -1
                case "AC":
                    return 0.0
                case "%":
                    return value / 100
                case "=":
                    return performTwoNumberCalculation(n2: value)
                default:
                    intermediateCalc = (n1: value, operation: symbol)
                    break
                }
            }
            
            return nil
        }
}
