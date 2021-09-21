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
    
    var delegate: AlgorithmDelegate?
    var textView: String = ""
    var numberFormatter = NumberFormatter()
    // Error check computed variables
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var expressionHaveResult: Bool {
        return textView.firstIndex(of: "=") != nil
    }
    var expressionIsEmpty: Bool {
        return textView == "0"
    }
    var elements: [String] {
        return textView.split(separator: " ").map { "\($0)" }
    }
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }
    func error() {
    }
    
    func symbolOperator(operatorTitle: String) {
        if canAddOperator {
            textView.append(" \(operatorTitle) ")
            delegate?.appendText(text: " \(textView) ")
        } else {
            delegate?.showAlert(title: "Erreur", message: "Un opérateur est déjà mis !")
        }
    }
    func tappedNumber(textNumber: String) {
        if expressionHaveResult || expressionIsEmpty {
            delegate?.appendText(text: "\(textNumber)")
        }
        textView.append("\(textNumber)")
        delegate?.appendText(text: "\(textView)")
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
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 4
        numberFormatter.usesSignificantDigits = true
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.allowsFloats = true
        numberFormatter.numberStyle = .decimal
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
        delegate?.appendText(text: " \(resultString)")
    }
    
    func reset() {
        textView.removeAll()
        delegate?.appendText(text: "0")
    }
    func priorityCalculate() {
        
    }
}
