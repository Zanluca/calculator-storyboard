//
//  ViewController.swift
//  CalculadoraStoryboard
//
//  Created by gabriel.zanluca on 20/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    let screen = CalculatorView()

    @IBOutlet weak var resultLabel: UILabel!
    var firstNumber = 0.0
    var resultNumber = 0.0
    var currentOperations : Operation?
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        setupNumpad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupNumpad() {
        let fontSize:CGFloat = 25
        
        let buttonSize: CGFloat = view.frame.size.width / 4
        let buttonHeight: CGFloat = view.frame.size.height / 7
        print("height: \(view.frame.size.height-buttonSize)")
        let zeroButton = UIButton(frame: CGRect(x: 0, y: view.frame.size.height-buttonHeight, width: buttonSize*2, height: buttonHeight))
        print(buttonSize)
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .yellow
        
        zeroButton.setTitle("0", for: .normal)
        
        zeroButton.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
        
        view.addSubview(zeroButton)
        
        for x in 1...3 {
            let button_row_1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x-1), y: view.frame.size.height-(buttonHeight*2), width: buttonSize, height: buttonHeight))
            button_row_1.setTitleColor(.black, for: .normal)
            button_row_1.backgroundColor = .yellow
            button_row_1.setTitle("\(x)", for: .normal)
            view.addSubview(button_row_1)
        }
        
        for x in 4...6 {
            let button_row_2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x-4), y: view.frame.size.height-(buttonHeight*3), width: buttonSize, height: buttonHeight))
            button_row_2.setTitleColor(.black, for: .normal)
            button_row_2.backgroundColor = .yellow
            button_row_2.setTitle("\(x)", for: .normal)
            view.addSubview(button_row_2)
        }
        
        for x in 7...9 {
            let button_row_3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x-7), y: view.frame.size.height-(buttonHeight*4), width: buttonSize, height: buttonHeight))
            button_row_3.setTitleColor(.black, for: .normal)
            button_row_3.backgroundColor = .yellow
            button_row_3.setTitle("\(x)", for: .normal)
            view.addSubview(button_row_3)
        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: view.frame.size.height-(buttonHeight*5), width: buttonSize, height: buttonHeight))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .yellow
        clearButton.setTitle("AC", for: .normal)
        
        view.addSubview(clearButton)
        
        let changeSignalButton = UIButton(frame: CGRect(x: buttonSize, y: view.frame.size.height-(buttonHeight*5), width: buttonSize, height: buttonHeight))
        changeSignalButton.setTitleColor(.black, for: .normal)
        changeSignalButton.backgroundColor = .yellow
        changeSignalButton.setTitle("+/-", for: .normal)
        
        view.addSubview(changeSignalButton)
        
        let percentButton = UIButton(frame: CGRect(x: buttonSize*2, y: view.frame.size.height-(buttonHeight*5), width: buttonSize, height: buttonHeight))
        percentButton.setTitleColor(.black, for: .normal)
        percentButton.backgroundColor = .yellow
        percentButton.setTitle("%", for: .normal)
        
        view.addSubview(percentButton)
        
        let dotButton = UIButton(frame: CGRect(x: buttonSize*2, y: view.frame.size.height-buttonHeight, width: buttonSize, height: buttonHeight))
        dotButton.setTitleColor(.black, for: .normal)
        dotButton.backgroundColor = .yellow
        dotButton.setTitle(".", for: .normal)
        
        view.addSubview(dotButton)
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

