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
    weak var delegate: AlgorithmDelegate?
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
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    func tappedOperator(operatorTitle: String) {
        if text != "" {
            if canAddOperator {
                text += " \(operatorTitle) "
                delegate?.appendText(text: " \(text) ")
                solvedOperation = false
            } else if operatorTitle == "-" && expressionIsCorrect {
                text += "\(operatorTitle)"
                delegate?.appendText(text: "\(text)")
                solvedOperation = false
            } else {
                delegate?.showAlert(title: "Erreur", message: "Un opérateur est déjà mis !")
            }
        } else if operatorTitle == "-" {
            text += " \(operatorTitle)"
            delegate?.appendText(text: " \(text)")
            solvedOperation = false
        } else {
            delegate?.showAlert(title: "Erreur", message: "Entrez une expression correcte !")
        }
    }
    func tappedNumber(textNumber: String) {
        if solvedOperation == true || expressionIsEmpty {
            text = ""
        }
        if elements.last == "÷" && textNumber == "0" {
            delegate?.showAlert(title: "Erreur", message: "Impossible !")
            canDivideByZero = false
            reset()
        } else {
            decimalNumber()
            text += "\(textNumber)"
            delegate?.appendText(text: "\(text)")
            solvedOperation = false
        }
    }
    func calculate() {
        guard canAddOperator else {
            delegate?.showAlert(title: "Erreur", message: "Entrez une expression correcte !")
            canCalculateByNothing = false
            return
        }
        guard expressionHaveEnoughElement else { return }
        // Create local copy of operations
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let indexOfMultiply = operationsToReduce.firstIndex { $0 == "×" }
            let indexOfDivide = operationsToReduce.firstIndex { $0 == "÷" }
            let operationIndex: Int
            if indexOfMultiply != nil && indexOfDivide == nil {
                operationIndex = indexOfMultiply!
            } else if indexOfMultiply == nil && indexOfDivide != nil {
                operationIndex = indexOfDivide!
            } else if indexOfMultiply != nil && indexOfDivide != nil {
                operationIndex = min(indexOfMultiply!, indexOfDivide!)
            } else {
                operationIndex = 1
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
            operationsToReduce.remove(at: operationIndex + 1)
            operationsToReduce.remove(at: operationIndex)
            operationsToReduce.remove(at: operationIndex - 1)
            operationsToReduce.insert("\(result)", at: operationIndex - 1)
        }
        let resultNumber = NSNumber(value: Double(operationsToReduce.first!)!)
        let resultString = numberFormatter.string(from: resultNumber) ?? ""
        // show result
        text = "\(resultString)"
        delegate?.appendText(text: " \(resultString)")
        solvedOperation = true
    }
    func reset() {
        text = ""
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
