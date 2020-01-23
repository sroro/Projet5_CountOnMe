//
//  Calculator.swift
//  CountOnMe
//
//  Created by Rodolphe Schnetzer on 21/01/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    
    var calculString: String = ""{
        didSet{
            NotificationCenter.default.post(Notification(name: Notification.Name("updateCalcul")))
        }
    }
    var elements: [String] {
          return calculString.split(separator: " ").map { "\($0)" }
      }
    
    // Error check computed variables
       var expressionIsCorrect: Bool {
           return elements.last != "+" && elements.last != "-"
       }
       
       var expressionHaveEnoughElement: Bool {
           return elements.count >= 3
       }
       
       var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
       }
       
       var expressionHaveResult: Bool {
           return calculString.firstIndex(of: "=") != nil
       }
    
    func addNumber(_ number: String){
        if expressionHaveResult {
            calculString = ""
        }
        calculString.append(number)
    }
    
    func addOperattor(_ element: String){
        if canAddOperator {
            switch element {
            case " + ":
                 calculString.append(" + ")
            case " - ":
                 calculString.append(" - ")
            default:
                 NotificationCenter.default.post(Notification(name: Notification.Name("error")))
            }
          
        } else {
             NotificationCenter.default.post(Notification(name: Notification.Name("error")))
        }
    }
    
    func equal() {
        guard expressionIsCorrect else {
                  return     NotificationCenter.default.post(Notification(name: Notification.Name("error2")))
               }
               
               guard expressionHaveEnoughElement else {
                 return    NotificationCenter.default.post(Notification(name: Notification.Name("error3")))
               }
               
               // Create local copy of operations
               var operationsToReduce = elements
               
               // Iterate over operations while an operand still here
               while operationsToReduce.count > 1 {
                   let left = Int(operationsToReduce[0])!
                   let operand = operationsToReduce[1]
                   let right = Int(operationsToReduce[2])!
                   
                   let result: Int
                   switch operand {
                   case "+": result = left + right
                   case "-": result = left - right
                   default: fatalError("Unknown operator !")
                   }
                   
                   operationsToReduce = Array(operationsToReduce.dropFirst(3))
                   operationsToReduce.insert("\(result)", at: 0)
               }
               
               calculString.append(" = \(operationsToReduce.first!)")
    }
    
}
