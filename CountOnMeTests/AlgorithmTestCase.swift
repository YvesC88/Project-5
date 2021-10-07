//
//  AlgorithmTestCase.swift
//  CountOnMeTests
//
//  Created by Yves Charpentier on 21/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class AlgorithmTestCase: XCTestCase {
    var algorithm: Algorithm!
    override func setUp() {
        super.setUp()
        algorithm = Algorithm()
    }
    // MARK: - Basics and complexes operations
    func testGivenOperation_WhenAddNumber_ThenCalculate() {
        algorithm.text = "6 + 3"
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "9")
    }
    func testGivenOperation_WhenSubstractNumber_ThenCalculate() {
        algorithm.text = "6 - 3"
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "3")
    }
    func testGivenOperation_WhenMultiplyNumber_ThenCalculate() {
        algorithm.text = "6 × 3"
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "18")
    }
    func testGivenOperation_WhenDivideNumber_ThenCalculate() {
        algorithm.text = "6 ÷ 3"
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "2")
    }
    func testGivenDecimalNumber_WhenDivideNumber_ThenCalculate() {
        algorithm.text = "3 ÷ 6"
        algorithm.decimalNumber()
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "0.5")
    }
    func testGivenNegativeNumber_WhenTapSubstractButton_ThenCalculate() {
        algorithm.text = "-3 × -3"
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "9")
    }
    func testGivenPriorityCalculate_WhenHaveMultiplyAndDivide_ThenCalculate() {
        algorithm.text = "1 + 2 × 3 ÷ 4"
        algorithm.decimalNumber()
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "2.5")
    }
    // MARK: - Multiple manipulations
    func testGivenShowNumber_WhenTapOnNumber_ThenShowingResult() {
        algorithm.tappedNumber(textNumber: "6")
        
        XCTAssert(algorithm.text == "6")
    }
    func testGivenShowNegativeNumber_WhenTapOnNumber_ThenShowingResult() {
        algorithm.tappedNumber(textNumber: "3")
        algorithm.tappedOperator(operatorTitle: "×")
        algorithm.tappedOperator(operatorTitle: "-")
        
        XCTAssert(algorithm.text == "3 × -")
    }
    func testGivenShowSubstractSign_WhenTapOnSubstractSign_ThenShowingResult() {
        algorithm.tappedOperator(operatorTitle: "-")
        
        XCTAssert(algorithm.text == " -")
    }
    func testGivenShowMultiplySign_WhenTapOnMultiplySign_ThenShowingResult() {
        algorithm.tappedOperator(operatorTitle: "×")
        
        XCTAssert(algorithm.text == "")
    }
    func testGivenExpressionIsCorrect_WhenTapOnSubstractSign_ThenShowingResult() {
        algorithm.tappedOperator(operatorTitle: "-")
        
        XCTAssertFalse(algorithm.isLastElementMultiplyOrDivide)
    }
    // MARK: - Error testing
    func testGivenDivide_WhenByZero_ThenError() {
        algorithm.tappedNumber(textNumber: "3")
        algorithm.tappedOperator(operatorTitle: "÷")
        algorithm.tappedNumber(textNumber: "0")
        
        XCTAssertFalse(algorithm.canDivideByZero)
    }
    func testGivenCalculate_WhenCanCalculateByNothing_ThenError() {
        algorithm.text = "6 + "
        algorithm.calculate()
        
        XCTAssertFalse(algorithm.canCalculateByNothing)
    }
    func testGivenTryToAddTwoSymbolsInARow_WhenTapOnNumberAndTwoSymbols_ThenImpossible() {
        algorithm.tappedNumber(textNumber: "3")
        algorithm.tappedOperator(operatorTitle: "-")
        algorithm.tappedOperator(operatorTitle: "÷")
        
        XCTAssert(algorithm.text == "3 - ")
    }
    // MARK: - Text clean and other
    func testCleanText_WhenTappedOnAC_ThenTextCleaned() {
        algorithm.reset()
        
        XCTAssert(algorithm.text == "")
    }
    func testGivenHaveAResult_WhenTapOnNumber_ThenTextCleaned() {
        algorithm.text = "6 + 3"
        algorithm.calculate()
        algorithm.tappedNumber(textNumber: "6")
        
        XCTAssertEqual(algorithm.solvedOperation, algorithm.text == "")
    }
    func testGivenExpressionIsEmpty_WhenTapEqual_ThenCalculate() {
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "")
    }
}
