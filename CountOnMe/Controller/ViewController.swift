//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var algorithm = Algorithm()
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var resetOperations: UIButton!
    @IBOutlet var additionButton: UIButton!
    @IBOutlet var substractionButton: UIButton!
    @IBOutlet var multiplyButton: UIButton!
    @IBOutlet var divideButton: UIButton!
    
    
    
    
    let numberFormatter = NumberFormatter()
    
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
        algorithm.tappedNumber([numberButtons])
    }
    @IBAction func tappedResetOperations(_ sender: UIButton) {
        algorithm.reset()
    }
    @IBAction func tappedOperator(_ sender: UIButton) {
        algorithm.symbolOperator(multiplyButton)
    }
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        algorithm.calculate()
    }
    func showResult() {
        let resultNumber = NSNumber(value: Double(operationsToReduce.first!)!)
        let resultString = numberFormatter.string(from: resultNumber) ?? ""
        textView.text.append(" = \(resultString)")
    }
}
