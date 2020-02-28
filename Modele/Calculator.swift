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
           return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
       }
       
       var expressionHaveEnoughElement: Bool {
           return elements.count >= 3
       }
       
       var canAddOperator: Bool {
           return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
       }
       
       var expressionHaveResult: Bool {
           return calculString.firstIndex(of: "=") != nil
       }
    
       var divideByZero: Bool {
           return calculString.contains("/ 0")
      }
    
    func addNumber(_ number: String){
        if expressionHaveResult {
            calculString = ""
        }
        calculString.append(number)
    }
    
        var canStartByOperator: Bool {
           if calculString >= "0" && calculString <= "9" {
               return elements.count >= 1
           } else {
              NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Commencez par un chiffre"]))
           }
           return false
       }
    
    func addition() {
        if canAddOperator && canStartByOperator {
           result()
           calculString.append(" + ")
        } else {
           NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Un operateur est déja mis !"]))
       }
    }
    
    func substraction() {
      if canAddOperator && canStartByOperator {
            result()
            calculString.append(" - ")
         } else {
            NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Un operateur est déja mis !"]))
        }
    }
    
    func multiplication() {
       if canAddOperator && canStartByOperator {
            result()
            calculString.append(" x ")
         } else {
            NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Un operateur est déja mis !"]))
        }
    }
    
    func division() {
       if canAddOperator && canStartByOperator {
            result()
            calculString.append(" / ")
         } else {
            NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Un operateur est déja mis !"]))
        }
    }
    
    func reset() {
        calculString = ""
    }
    
    /*  If have a result, put in a var the last element (so the result)
         therefore calculString will display the result */
    func result() {
        if expressionHaveResult{
           if let resultat = elements.last {
                   calculString = resultat
            }
        }
    }
    
    func equal() {
        guard !expressionHaveResult else {
           return     NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Entrez une nouvelle opération"]))
        }
        
        guard expressionIsCorrect else {
            calculString = ""
            return     NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Entrez une expression correcte"]))
        }
               
        guard expressionHaveEnoughElement else {
            return    NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Commencez un nouveau calcul"]))
        }
        
        guard divideByZero == false else {
            calculString = ""
            return    NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Division par 0 impossible"]))
        }
        
               // Create local copy of operations
               var operationsToReduce = elements
               
               // Iterate over operations while an operand still here
               while operationsToReduce.count > 1 {
                
                   guard var left = Double(operationsToReduce[0]) else { return }
                   var operand = operationsToReduce[1]
                   guard var right = Double(operationsToReduce[2]) else { return }
                   var operandIndex = 1 // because no sign will be at base index 0 otherwise error
               
                let result: Double
                
                // check if operation have operator * or / for make priority of calcul
                if let index = operationsToReduce.firstIndex(where: {["x","/"].contains($0)}){
                     operandIndex = index
                if let leftUnwrap = Double(operationsToReduce[index - 1]) { left = leftUnwrap}
                      operand = operationsToReduce[index]
                if let rightUnwrap = Double(operationsToReduce[index + 1]) { right = rightUnwrap}
                }
                
                result = calculate(left: left, right: right, operand: operand)
                
               for _ in 1...3 {
                    operationsToReduce.remove(at: operandIndex - 1)
                }
                
                operationsToReduce.insert(formatResult(result: result), at: operandIndex - 1 )
               }
    
               calculString.append(" = \(operationsToReduce.first!)")
    }
    
 func calculate(left: Double, right: Double, operand: String) -> Double {
        let result: Double
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "x": result = left * right
        case "/": result = left / right
        default: fatalError("Unknown operator !")
        }
        return result
    }
    
/* function to format the result at max 2 digits after comma,
     if the number ends in .0 then displays whole */
    func formatResult(result: Double) -> String! {
      let formatter = NumberFormatter()
      formatter.maximumFractionDigits = 2
      guard let resultFormated = formatter.string(from: NSNumber(value: result)) else { return nil
      }
      return resultFormated
    }
    
}


