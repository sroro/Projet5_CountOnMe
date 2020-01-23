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

    var calculatorTest: Calculator!
    
    override func setUp() {
        super.setUp()
       calculatorTest = Calculator()
    }
    
    func testGiven_WhenAddElement_ThenLastElementDifferentOfPlusOrLess(){
        
        //Given
        
        //When
        calculatorTest.calculString = "1";"+";"1"
        
        //Then
        XCTAssertTrue(calculatorTest.calculString.last != "+" && calculatorTest.calculString.last != "-" )
         XCTAssertTrue(calculatorTest.canAddOperator)
    }
    
    
    func testGiven0elements_WhenAddElement_ThenHaveElements(){
           
           //Given
           
           //When
        calculatorTest.addNumber("1")
           
           //Then
        XCTAssert(calculatorTest.calculString == "1")
        
           
       }


}
