//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let algorithm = Algorithm()
    @IBOutlet var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var resetOperations: UIButton!
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        algorithm.delegate = self
    }
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        algorithm.tappedNumber(textNumber: sender.title(for: .normal)!)
    }
    @IBAction func tappedResetOperations(_ sender: UIButton) {
        algorithm.reset()
    }
    @IBAction func tappedOperator(_ sender: UIButton) {
        algorithm.tappedOperator(operatorTitle: sender.title(for: .normal)!)
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
        textView.text = text
    }
}
