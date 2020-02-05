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
            case " * ":
                 calculString.append(" * ")
            case " / ":
                 calculString.append(" / ")
            default:
                break
            }
            } else {
            NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Un operateur est déja mis !"]))
            }
        }
    
    func equal() {
        guard expressionIsCorrect else {
            return     NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Entrez une expression correcte"]))
               }
               
               guard expressionHaveEnoughElement else {
                 return    NotificationCenter.default.post(Notification(name: Notification.Name("error"), userInfo: ["message":"Commencez un nouveau calcul"]))
               }
               
               // Create local copy of operations
               var operationsToReduce = elements
               
               // Iterate over operations while an operand still here
        // https://openclassrooms.com/fr/courses/4287521-apprenez-les-fondamentaux-de-swift/4328711-comprenez-les-optionnels
               while operationsToReduce.count > 1 {
                
                   var left = Double(operationsToReduce[0])!
                   var operand = operationsToReduce[1]
                   var right = Double(operationsToReduce[2])!
                   
                   var operandIndex = 1 // car aucun signe sera a l'index 0 de base sinon erreur
                   
                let result: Double
                
               if let index = operationsToReduce.firstIndex(where: {["*","/"].contains($0)}){
              
                     operandIndex = index
                     left = Double(operationsToReduce[index - 1])!
                     operand = operationsToReduce[index]
                     right = Double(operationsToReduce[index + 1])!
                    
                }
                 
                result = calculate(left: left, right: right, operand: operand)
                print(result)
                
                for _ in 1...3 {
                  
                    operationsToReduce.remove(at: operandIndex - 1)
                    print(operationsToReduce)
                    print(result)
                }
                
                   operationsToReduce.insert("\(result)", at: operandIndex - 1 )
                    print(operationsToReduce)
               }
               
               calculString.append(" = \(operationsToReduce.first!)")
    }
    
    
    
 func calculate(left: Double, right: Double, operand: String) -> Double {
        let result: Double
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "*": result = left * right
        case "/": result = left / right
        default: fatalError("Unknown operator !")
        }
        return result
    }
}
