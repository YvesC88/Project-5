//
//  Algorithm.swift
//  CountOnMe
//
//  Created by Yves Charpentier on 10/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol AlgorithmDelegate: AnyObject {
    func showAlert(title: String?, message: String?)
    func appendText(text: String)
}

class Algorithm {
    // declaration of var & let
    weak var delegate: AlgorithmDelegate?
    let error: String = "Erreur"
    let errorMessage: String = "Entrez une expression correcte !"
    var text: String = ""
    var solvedOperation: Bool = false
    var canDivideByZero: Bool = false
    var canCalculateByNothing: Bool = false
    var numberFormatter = NumberFormatter()
    // Error check computed variables
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    var expressionIsEmpty: Bool {
        return text == "0"
    }
    var elements: [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }
    var isLastElementMultiplyOrDivide: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    var textIsNotEmpty: Bool {
        return text != ""
    }
    
    func tappedOperator(operatorTitle: String) {
        if textIsNotEmpty {
            if canAddOperator {
                text += " \(operatorTitle) "
                delegate?.appendText(text: " \(text) ")
                solvedOperation = false
            } else if operatorTitle == "-" && isLastElementMultiplyOrDivide {
                text += "\(operatorTitle)"
                delegate?.appendText(text: "\(text)")
                solvedOperation = false
            } else {
                delegate?.showAlert(title: error, message: "Un opérateur est déjà mis !")
            }
        } else if operatorTitle == "-" {
            text += " \(operatorTitle)"
            delegate?.appendText(text: " \(text)")
            solvedOperation = false
        } else {
            delegate?.showAlert(title: error, message: errorMessage)
        }
    }
    
    func tappedNumber(textNumber: String) {
        if solvedOperation == true || expressionIsEmpty {
            text = ""
        }
        guard elements.last == "÷" && textNumber == "0" else {
            decimalNumber()
            text += "\(textNumber)"
            delegate?.appendText(text: "\(text)")
            solvedOperation = false
            return
        }
        delegate?.showAlert(title: error, message: "Impossible !")
        canDivideByZero = false
        reset()
    }
    
    func calculate() {
        guard canAddOperator else {
            delegate?.showAlert(title: error, message: errorMessage)
            canCalculateByNothing = false
            return
        }
        guard expressionHaveEnoughElement else { return }
        // Create local copy of operations
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            // Rules of priority on calculation
            let indexOfMultiply = operationsToReduce.firstIndex { $0 == "×" }
            let indexOfDivide = operationsToReduce.firstIndex { $0 == "÷" }
            var operationIndex = 1
            if indexOfMultiply != nil && indexOfDivide == nil {
                operationIndex = indexOfMultiply!
            } else if indexOfMultiply == nil && indexOfDivide != nil {
                operationIndex = indexOfDivide!
            } else if indexOfMultiply != nil && indexOfDivide != nil {
                operationIndex = min(indexOfMultiply!, indexOfDivide!)
            }
            let left = Double(operationsToReduce[operationIndex - 1])!
            let operand = operationsToReduce[operationIndex]
            let right = Double(operationsToReduce[operationIndex + 1])!
            var result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }
            operationsToReduce.replaceSubrange((operationIndex - 1)...(operationIndex + 1), with: ["\(result)"])
        }
        let resultNumber = NSNumber(value: Double(operationsToReduce.first!)!)
        let resultString = numberFormatter.string(from: resultNumber) ?? ""
        // Show result
        text = "\(resultString)"
        delegate?.appendText(text: " \(resultString)")
        solvedOperation = true
    }
    func reset() {
        text.removeAll()
        delegate?.appendText(text: "0")
    }
    func decimalNumber() {
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 3
        numberFormatter.usesSignificantDigits = true
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.allowsFloats = true
        numberFormatter.numberStyle = .decimal
        numberFormatter.usesGroupingSeparator = false
    }
}
