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
    func testGivenNumberOne_WhenLastElementIsMore_ThenExpressionIsNotCorrect() {
        calculator.addNumber("1")
        calculator.addition()
        XCTAssertFalse(calculator.expressionIsCorrect)
        
    }
    
        func testGivenCalculStringHaveResult_WhenReset_ThenCalculStringIsEmpty(){
        calculator.reset()
               
               XCTAssertEqual(calculator.calculString, "")
        
        
    }
    
     // test addOperator ( + )
    func testGivenCalculstringIsEmpty_WhenMakeOperation_ThenHaveResult(){
        calculator.calculString = "1 + 1"
        calculator.equal()
        XCTAssertEqual(calculator.calculString, "1 + 1 = 2")
        
    }
    
    // test notification "un operateur est deja mit"
    func testGivenCalculStringLastWithOperator_WhenAddingOperator_ThenNotificationTriggered(){
        calculator.calculString = "2 + "
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.substraction()
        calculator.addition()
        calculator.multiplication()
        calculator.division()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    // test notification "entrer une expression correct"
    func testGivenCalculStringLastWithOperator_WhenMakingCalculation_ThenNotificationTriggered(){
        calculator.calculString = "2 + "
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.equal()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testGivenCalculStringStartWithOperator_WhenMakingCalculation_ThenNotificationTriggered(){
               calculator.multiplication()
             
               XCTAssertEqual(calculator.calculString, "")
           
       }

    
    
    // test addOperator ( - )
    func testGivenCalculstringIsEmpty_WhenMakeMinusOperation_ThenHaveResult(){
        
        calculator.addNumber("1")
        calculator.substraction()
        calculator.addNumber("1")
        calculator.equal()
        
        XCTAssertEqual(calculator.calculString, "1 - 1 = 0")
    }
    
    
  
    
    func testGivenCalculIsEmpty_WhenMakingVariousOperation_ThenResultIsGood(){
          
        calculator.addNumber("6")
        calculator.addition()
        calculator.addNumber("4")
        calculator.equal()
        calculator.division()
        calculator.addNumber("5")
        calculator.equal()
                
        XCTAssertTrue(calculator.calculString == "10 / 5 = 2")
          }
    
    func testGivenCalculHasBeenMade_WhenResultAndAddNumber_ThenResultIsNewNumber(){
    
                calculator.calculString = "6 + 4 = 10"
                calculator.addNumber("2")
          
                
        XCTAssertEqual(calculator.calculString, "2")
    }
    
    
    func testGivenCalculStringIsEmpty_WhenMakeDivisionByZero_ThenHaveAnError() {
        
        calculator.calculString = "2 / 0"
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.equal()
        waitForExpectations(timeout: 0.1, handler: nil)
        
        
    }
    
    func testGivenCalculStringIsEmptyAnother_WhenTappedTwoTimesEqual_ThenHaveAnError() {
        
        calculator.calculString = "2 + 2 = 4"
        expectation(forNotification: NSNotification.Name(rawValue: "error"), object: nil, handler: nil)
        calculator.equal()
        calculator.equal()
        waitForExpectations(timeout: 0.1, handler: nil)
        
        
    }
    
    // MARK: -TDD
    
    
    func testGivenCalculstringIsEmpty_WhenMakeMultiplicationOperation_ThenHaveResult(){
           
           calculator.addNumber("2")
           calculator.multiplication()
           calculator.addNumber("3")
           calculator.equal()
           
           XCTAssertEqual(calculator.calculString, "2 x 3 = 6")
       }
    
    func testGivenCalculstringIsEmpty_WhenMakeDivisionOperation_ThenHaveResult(){
        
        calculator.addNumber("6")
        calculator.division()
        calculator.addNumber("3")
        calculator.equal()
        
        XCTAssertEqual(calculator.calculString, "6 / 3 = 2")
        
    }
    
    
    func testGivenCalculstringIsEmpty_WhenMakeDAdditionAndMultiplicationOperation_ThenHaveResultInGoodOrder(){

        calculator.addNumber("6")
        calculator.addition()
        calculator.addNumber("3")
        calculator.multiplication()
        calculator.addNumber("2")
        calculator.equal()
        
        XCTAssertEqual(calculator.calculString, "6 + 3 x 2 = 12")
        
    }
    
    func testGivenCalculstringIsEmpty_WhenMakeDAdditionAndDivisionOperation_ThenHaveResultInGoodOrder(){
        
        calculator.addNumber("6")
        calculator.addition()
        calculator.addNumber("4")
        calculator.division()
        calculator.addNumber("2")
        calculator.equal()
        
        XCTAssertEqual(calculator.calculString, "6 + 4 / 2 = 8")
        
    }
    
    func testGivenCalculstringIsEmpty_WhenMakeDAdditionAndMultiplicationAndDivisionOperation_ThenHaveResultInGoodOrder(){
           
           calculator.addNumber("6")
           calculator.addition()
           calculator.addNumber("4")
           calculator.multiplication()
           calculator.addNumber("10")
           calculator.division()
           calculator.addNumber("2")
           calculator.equal()
           
           XCTAssertEqual(calculator.calculString, "6 + 4 x 10 / 2 = 26")
           
       }
    
    
}
