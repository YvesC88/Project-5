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
//    
    func testGivenOperation_WhenAddNumber_ThenCalculate() {
        algorithm.text = "6 + 3"
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "6 + 3 = 9")
    }
    func testGivenOperation_WhenSubstractNumber_ThenCalculate() {
        algorithm.text = "6 - 3"
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "6 - 3 = 3")
    }
    func testGivenOperation_WhenMultiplyNumber_ThenCalculate() {
        algorithm.text = "6 × 3"
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "6 × 3 = 18")
    }
    func testGivenOperation_WhenDivideNumber_ThenCalculate() {
        algorithm.text = "6 ÷ 3"
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "6 ÷ 3 = 2")
    }
    func testGivenDivide_WhenDivideNumber_ThenDecimalNumber() {
        algorithm.text = "3 ÷ 6"
        algorithm.calculate()
        
        XCTAssert(algorithm.text == "3 ÷ 6 = 0.5")
    }
    func testCleanText_WhenTappedOnAC_ThenCleaned() {
        algorithm.reset()
        
        XCTAssert(algorithm.text == "")
    }
    func testGivenOperation_WhenDivideByZero_ThenError() {
        algorithm.text = "2 ÷"
        algorithm.tappedNumber(textNumber: "0")
        
        XCTAssert(algorithm.resultOfDivideByZero == "Erreur")
    }
}
