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
    var numberFormatter = NumberFormatter()
    // Error check computed variables
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
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
    var cantDivideByZero: Bool {
        return text.contains("÷")
    }
    func tappedOperator(operatorTitle: String) {
        if expressionHaveResult {
            text = text.components(separatedBy: "=").last!
        }
        guard text != "" else {
            delegate?.showAlert(title: "Erreur", message: "Commencez votre calcul avec un chiffre !")
            return
        }
        if canAddOperator {
            text += " \(operatorTitle) "
            delegate?.appendText(text: " \(text) ")
        } else {
            delegate?.showAlert(title: "Erreur", message: "Un opérateur est déjà mis !")
        }
    }
    func tappedNumber(textNumber: String) {
        if textNumber == "0" && cantDivideByZero {
            delegate?.showAlert(title: "Erreur", message: "Impossible !")
            reset()
        }
        if expressionHaveResult || expressionIsEmpty {
            text = ""
        }
        text += "\(textNumber)"
        delegate?.appendText(text: "\(text)")
    }
    func calculate() {
        guard canAddOperator else {
            delegate?.showAlert(title: "Erreur", message: "Entrez une expression correcte !")
            return
        }
        guard expressionHaveEnoughElement else {
            delegate?.showAlert(title: "Erreur", message: "Démarrez un nouveau calcul !")
            return
        }
        // Create local copy of operations
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            var result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        let resultNumber = NSNumber(value: Double(operationsToReduce.first!)!)
        let resultString = numberFormatter.string(from: resultNumber) ?? ""
        // show result
        text += " = \(resultString)"
        delegate?.appendText(text: "\(resultString)")
    }
    func reset() {
        text = ""
        delegate?.appendText(text: "0")
    }
    func decimalNumber() {
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 4
        numberFormatter.usesSignificantDigits = true
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.allowsFloats = true
        numberFormatter.numberStyle = .decimal
    }
}
// text = 1 + 2 * 3
// var result: Double
// var leftOperation: Double
// var rightOperation: Double
// leftOperation = text.components(separatedBy: "+").first!
// rightOperation = text.components(separatedBy: "+").last!
// result = leftOperation + rightOperation
