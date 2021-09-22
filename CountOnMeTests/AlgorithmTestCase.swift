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
    
    func testGivenCalculate_WhenAddNumber_ThenResult() {
        algorithm.text = "2 + 3"
        
        XCTAssert(algorithm.text == "2 + 3 = 5")
        
    }
    func testGivenCalculate_WhenSubstractNumber_ThenResult() {
        algorithm.text = "2 - 3"
        
        XCTAssert(algorithm.text == "2 - 3 = - 1")
        
    }
    func testGivenCalculate_WhenMultiplyNumber_ThenResult() {
        algorithm.text = "2 × 3"
        
        XCTAssert(algorithm.text == "2 × 3 = 6")
        
    }
    func testGivenCalculate_WhenDivideNumber_ThenResult() {
        algorithm.calculate()
        
        XCTAssert(true)
        
    }

}
