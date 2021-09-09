//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var resetOperations: UIButton!
    @IBOutlet var additionButton: UIButton!
    @IBOutlet var substractionButton: UIButton!
    @IBOutlet var multiplyButton: UIButton!
    @IBOutlet var divideButton: UIButton!
    
    let numberFormatter = NumberFormatter()
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    // Error check computed variables
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    var expressionIsEmpty: Bool {
        return textView.text == "0"
    }
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 4
        numberFormatter.usesSignificantDigits = true
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.allowsFloats = true
        numberFormatter.numberStyle = .decimal
    }
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult || expressionIsEmpty {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    @IBAction func tappedResetOperations(_ sender: UIButton) {
        textView.text = "0"
    }
    @IBAction func tappedOperator(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" \(sender.title(for: .normal)!) ")
            } else {
                let alertVC = UIAlertController(title: "Zéro!", message: "Un opérateur est déja mis !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
    }
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard canAddOperator else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        // Create local copy of operations
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            let result: Double
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
        textView.text.append(" = \(resultString)")
    }
    func priorityOperator() {
        
    }
}
