//
//  CalculatorTests.swift
//  CountOnMeTests
//
//  Created by Rodolphe Schnetzer on 23/01/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe 

class CalculatorTests: XCTestCase {

  var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
       calculator = Calculator()
    }
    
    // MARK: - test unitaire
    
    // test isCorrect
    func testGivenNumberOne_WhenLastElementIsLess_ThenExpressionIsNotCorrect() {
        calculator.addNumber("1")
        calculator.addOperattor(" + ")
        calculator.equal()
        XCTAssertFalse(calculator.expressionIsCorrect)
        
    }
    
     // test addOperator ( + )
    func testGivenCalculstringIsEmpty_WhenMakeOperation_ThenHaveResult(){
        calculator.addNumber("1")
        calculator.addOperattor(" + ")
        calculator.addNumber("1")
        calculator.equal()
        XCTAssertEqual(calculator.calculString, "1 + 1 = 2.0")
        
    }
    
    // test notification "un operateur est deja mit"
    func testGivenCalculStringLastWithOperator_WhenAddingOperator_ThenNotificationTriggered(){
        calculator.calculString = "2 + "
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.addOperattor(" - ")
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    // test notification "entrer une expression correct"
    func testGivenCalculStringLastWithOperator2_WhenAddingOperator_ThenNotificationTriggered(){
        calculator.calculString = "2 + "
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.equal()
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    
    
    // test addOperator ( - )
    func testGivenCalculstringIsEmpty_WhenMakeMinusOperation_ThenHaveResult(){
        
        calculator.addNumber("1")
        calculator.addOperattor(" - ")
        calculator.addNumber("1")
        calculator.equal()
        
        XCTAssertEqual(calculator.calculString, "1 - 1 = 0.0")
        
    }
    
    
    // test du break dans addOperator
    func testGivenCalculstringIsEmpty_WhenDOperation_ThenHaveResult(){
        
        calculator.addNumber("1")
        calculator.addOperattor(" d ")
        calculator.addNumber("1")
        calculator.equal()
        
        XCTAssertEqual(calculator.calculString, "11")
        
    }
    
    // MARK: -TDD
    
    
    func testGivenCalculstringIsEmpty_WhenMakeMultiplicationOperation_ThenHaveResult(){
           
           calculator.addNumber("2")
           calculator.addOperattor(" * ")
           calculator.addNumber("3")
           calculator.equal()
           
           XCTAssertEqual(calculator.calculString, "2 * 3 = 6.0")
           
       }
    
    func testGivenCalculstringIsEmpty_WhenMakeDivisionOperation_ThenHaveResult(){
        
        calculator.addNumber("6")
        calculator.addOperattor(" / ")
        calculator.addNumber("3")
        calculator.equal()
        
        XCTAssertEqual(calculator.calculString, "6 / 3 = 2.0")
        
    }
    
    
    func testGivenCalculstringIsEmpty_WhenMakeDAdditionAndMultiplicationOperation_ThenHaveResultInGoodOrder(){
        
        calculator.addNumber("6")
        calculator.addOperattor(" + ")
        calculator.addNumber("3")
        calculator.addOperattor(" * ")
        calculator.addNumber("2")
        calculator.equal()
        
        XCTAssertEqual(calculator.calculString, "6 + 3 * 2 = 12.0")
        
    }
    
    func testGivenCalculstringIsEmpty_WhenMakeDAdditionAndDivisionOperation_ThenHaveResultInGoodOrder(){
        
        calculator.addNumber("6")
        calculator.addOperattor(" + ")
        calculator.addNumber("4")
        calculator.addOperattor(" / ")
        calculator.addNumber("2")
        calculator.equal()
        
        XCTAssertEqual(calculator.calculString, "6 + 4 / 2 = 8.0")
        
    }
    
    func testGivenCalculstringIsEmpty_WhenMakeDAdditionAndMultiplicationAndDivisionOperation_ThenHaveResultInGoodOrder(){
           
           calculator.addNumber("6")
           calculator.addOperattor(" + ")
           calculator.addNumber("4")
           calculator.addOperattor(" * ")
           calculator.addNumber("10")
           calculator.addOperattor(" / ")
           calculator.addNumber("2")
           calculator.equal()
           
           XCTAssertEqual(calculator.calculString, "6 + 4 * 10 / 2 = 26.0")
           
       }
    
    
    
  

}
