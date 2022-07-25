//
//  ViewController.swift
//  CalculadoraStoryboard
//
//  Created by gabriel.zanluca on 20/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    var firstNumber = 0.0
    var resultNumber = 0.0
    var currentOperations : Operation?
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func clearResult(_ sender: Any) {
        currentOperations = nil
        resultLabel.text = "0"
        firstNumber = 0
    }
    
    func numberPressed(_ sender: UIButton) {
        if let number = sender.titleLabel?.text {
            if (resultLabel.text == "0") {
                resultLabel.text = "\(number)"
            } else if let text = resultLabel.text {
                resultLabel.text = "\(text)\(number)"
            }
        }
    }
    
    func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Double(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        
        if tag == 1 { // equals
            if let operation = currentOperations {
                if let text = resultLabel.text, let secondNumber = Double(text) {
                    
                        switch operation {
                        case .add:
                            firstNumber = firstNumber + secondNumber
                            resultLabel.text = "\(firstNumber)"
                            currentOperations = nil
                            firstNumber = 0
                            break
                        case .subtract:
                            firstNumber = firstNumber - secondNumber
                            resultLabel.text = "\(firstNumber)"
                            currentOperations = nil
                            firstNumber = 0
                            break
                        case .multiply:
                            firstNumber = firstNumber * secondNumber
                            resultLabel.text = "\(firstNumber)"
                            currentOperations = nil
                            firstNumber = 0
                            break
                        case .divide:
                            if secondNumber == 0 {
                                return
                            }
                            
                            firstNumber = firstNumber / secondNumber
                            resultLabel.text = "\(firstNumber)"
                            currentOperations = nil
                            firstNumber = 0
                            break
                    }
                }
            }
        } else if tag == 2 {
            currentOperations = .add
        } else if tag == 3 {
            currentOperations = .subtract
        } else if tag == 4 {
            currentOperations = .multiply
        } else if tag == 5 {
            currentOperations = .divide
        }
    }
    
    @IBAction func dotPress(_ sender: UIButton) {
        if (resultLabel.text != nil) {
            resultLabel.text! += "."
        }
    }
    
    @IBAction func percentPress(_ sender: UIButton) {
        if let text = resultLabel.text, let value = Float(text) {
            resultLabel.text = "\(value / 100)"
        }
    }
    
    @IBAction func changeSign(_ sender: UIButton) {
        if resultLabel.text != "0" {
            if let text = resultLabel.text, let value = Float(text) {
                resultLabel.text = "\(value * (-1))"
            }
        }
    }
    
    @IBAction func divide(_ sender: UIButton) {
        operationPressed(sender)
    }
    
    @IBAction func multiplyPress(_ sender: UIButton) {
        operationPressed(sender)
    }
    
    @IBAction func minusPress(_ sender: UIButton) {
        operationPressed(sender)
    }
    
    @IBAction func plusPress(_ sender: UIButton) {
        operationPressed(sender)
    }
    
    @IBAction func equalsPress(_ sender: UIButton) {
        operationPressed(sender)
    }
    
    @IBAction func pressNumber0(_ sender: Any) {
        if resultLabel.text != "0" {
        if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
    @IBAction func pressNumber1(_ sender: UIButton) {
        numberPressed(sender)
    }
    
    @IBAction func pressNumber2(_ sender: UIButton) {
        numberPressed(sender)
    }
    
    @IBAction func pressNumber3(_ sender: UIButton) {
        numberPressed(sender)
    }
    
    @IBAction func pressNumber4(_ sender: UIButton) {
        numberPressed(sender)
    }
    
    @IBAction func pressNumber5(_ sender: UIButton) {
        numberPressed(sender)
    }
    
    @IBAction func pressNumber6(_ sender: UIButton) {
        numberPressed(sender)
    }
    
    @IBAction func pressNumber7(_ sender: UIButton) {
        numberPressed(sender)
    }
    
    @IBAction func pressNumber8(_ sender: UIButton) {
        numberPressed(sender)
    }
    
    @IBAction func pressNumber9(_ sender: UIButton) {
        numberPressed(sender)
    }
}

