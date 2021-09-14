//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    private var algorithm = Algorithm()
    private let numberFormatter = NumberFormatter()
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var resetOperations: UIButton!
    @IBOutlet var additionButton: UIButton!
    @IBOutlet var substractionButton: UIButton!
    @IBOutlet var multiplyButton: UIButton!
    @IBOutlet var divideButton: UIButton!
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        algorithm.delegate = self
        
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 4
        numberFormatter.usesSignificantDigits = true
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.allowsFloats = true
        numberFormatter.numberStyle = .decimal
    }
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        algorithm.tappedNumber(numberTitle: sender.title(for: .normal)!)
    }
    @IBAction func tappedResetOperations(_ sender: UIButton) {
        algorithm.reset()
    }
    @IBAction func tappedOperator(_ sender: UIButton) {
        algorithm.symbolOperator(operatorTitle: sender.title(for: .normal)!)
    }
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        algorithm.calculate()
    }
}

extension ViewController: AlgorithmDelegate {
    func showAlert(title: String?, message: String?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func appendText(text: String) {
        textView.text.append(text)
    }
}
