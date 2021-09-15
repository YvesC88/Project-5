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
    func resetText(text: String)
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
        guard canAddOperator else {
            delegate?.showAlert(title: "Zéro !", message: "Entrez une expression correcte !")
            return
        }
        guard expressionHaveEnoughElement else {
            delegate?.showAlert(title: "Zéro", message: "Démarrez un nouveau calcul !")
            return
        }
    }
    func symbolOperator(operatorTitle: String) {
        if canAddOperator {
            delegate?.appendText(text: " \(operatorTitle) ")
        } else {
            delegate?.showAlert(title: "Zéro !", message: "Un opérateur est déjà mis !")
        }
    }
    func tappedNumber(textNumber: String) {
        guard (delegate?.appendText(text: "\(textNumber)")) != nil else {
            return
        }
        if expressionHaveResult || expressionIsEmpty {
            delegate?.appendText(text: "")
        }
        textView.append(textNumber)
    }
    func calculate() {
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
        textView.append("\(resultString)")
    }
    func reset() {
        delegate?.resetText(text: "")
    }
    func priorityCalculate() {
        
    }
}
