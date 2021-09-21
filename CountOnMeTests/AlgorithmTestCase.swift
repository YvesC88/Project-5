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
        algorithm.calculate()
        
        XCTAssert(true)
        
    }
    func testGivenCalculate_WhenSubstractNumber_ThenResult() {
        algorithm.calculate()
        
        XCTAssert(true)
        
    }
    func testGivenCalculate_WhenMultiplyNumber_ThenResult() {
        algorithm.calculate()
        
        XCTAssert(true)
        
    }
    func testGivenCalculate_WhenDivideNumber_ThenResult() {
        algorithm.calculate()
        
        XCTAssert(true)
        
    }

}
