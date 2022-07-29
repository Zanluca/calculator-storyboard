//
//  CalculatorView.swift
//  CalculadoraStoryboard
//
//  Created by gabriel.zanluca on 27/07/22.
//

import UIKit
final class CalculatorView: UIView, CodeView {
    
    var firstNumber = 0.0
    var resultNumber = 0.0
    var currentOperations : Operation?
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    lazy var topView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 90)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func numberPressed(_ sender: UIButton) {
        if let number = sender.titleLabel?.text {
            if (resultLabel.text == "0") {
                resultLabel.text = "\(number)"
            } else if let text = resultLabel.text {
                resultLabel.text = "\(text)\(number)"
            }
        }
    }
    
    @objc private func zeroPressed(_ sender: UIButton) {
        if resultLabel.text != "0" {
        if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
    @objc private func operationPressed(_ sender: UIButton) {
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
    
    @objc private func clearResult(_ sender: UIButton) {
        currentOperations = nil
        resultLabel.text = "0"
        firstNumber = 0
    }
    
    @objc func dotPress(_ sender: UIButton) {
        if let text = resultLabel.text, !text.contains(".") {
            resultLabel.text! += "."
        }
    }
    
    @objc func percentPress(_ sender: UIButton) {
        if let text = resultLabel.text, let value = Float(text) {
            resultLabel.text = "\(value / 100)"
        }
    }
    
    @objc func changeSign(_ sender: UIButton) {
        if resultLabel.text != "0" {
            if let text = resultLabel.text, let value = Float(text) {
                resultLabel.text = "\(value * (-1))"
            }
        }
    }
    
    private func setupNumpad() {
        let fontSize:CGFloat = 37
        
        let zeroButton = UIButton(frame: .zero)
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.backgroundColor = .darkGray
        
        zeroButton.setTitle("0", for: .normal)
        
        zeroButton.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
        zeroButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.addSubview(zeroButton)
        
        zeroButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 2/4, constant: 0).isActive = true
        zeroButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 1/5, constant: 0).isActive = true
        zeroButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        zeroButton.addTarget(self, action: #selector(zeroPressed(_:)), for: .touchUpInside)
        zeroButton.layer.borderWidth = 2
        zeroButton.layer.borderColor = UIColor.black.cgColor
        
        let dotButton = UIButton(frame: .zero)
        dotButton.setTitleColor(.white, for: .normal)
        dotButton.backgroundColor = .darkGray
        
        dotButton.setTitle(".", for: .normal)
        
        dotButton.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
        dotButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.addSubview(dotButton)
        
        dotButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 1/4, constant: 0).isActive = true
        dotButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 1/5, constant: 0).isActive = true
        dotButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        dotButton.leftAnchor.constraint(equalTo: zeroButton.rightAnchor).isActive = true
        dotButton.addTarget(self, action: #selector(dotPress(_:)), for: .touchUpInside)
        dotButton.layer.borderWidth = 2
        dotButton.layer.borderColor = UIColor.black.cgColor
        
        var previousButton : UIButton?
        var sideButton: UIButton? = nil
        var count = 0
        
        for _ in 1...3 {
            previousButton = sideButton
            sideButton = nil
            for _ in 1...3 {
                let actualButton = UIButton(frame: .zero)
                actualButton.setTitleColor(.white, for: .normal)
                actualButton.backgroundColor = .darkGray
                count+=1
                actualButton.setTitle("\(count)", for: .normal)
                actualButton.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
                actualButton.translatesAutoresizingMaskIntoConstraints = false
                actualButton.layer.borderWidth = 2
                actualButton.layer.borderColor = UIColor.black.cgColor
                
                bottomView.addSubview(actualButton)
                
                actualButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 1/4, constant: 0).isActive = true
                actualButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 1/5, constant: 0).isActive = true
                if (previousButton == nil) {
                    actualButton.bottomAnchor.constraint(equalTo: zeroButton.topAnchor).isActive = true
                } else {
                    actualButton.bottomAnchor.constraint(equalTo: previousButton!.topAnchor).isActive = true
                }
                
                if (sideButton !== nil) {
                    actualButton.leftAnchor.constraint(equalTo: sideButton!.rightAnchor).isActive = true
                }
                actualButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                sideButton = actualButton
            }
        }
        
        let operations = ["=", "+", "-", "×", "÷"]
        
        previousButton = nil
        
        for count in 0...operations.count - 1 {
            let operationButton = UIButton(frame: .zero)
            operationButton.setTitleColor(.white, for: .normal)
            operationButton.backgroundColor = .systemOrange
            operationButton.setTitle(operations[count], for: .normal)
            operationButton.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
            operationButton.translatesAutoresizingMaskIntoConstraints = false
            operationButton.tag = count+1
            operationButton.layer.borderWidth = 2
            operationButton.layer.borderColor = UIColor.black.cgColor
            
            bottomView.addSubview(operationButton)
            operationButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 1/4, constant: 0).isActive = true
            operationButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 1/5, constant: 0).isActive = true
            operationButton.leftAnchor.constraint(equalTo: dotButton.rightAnchor).isActive = true
            
            if (previousButton == nil) {
                operationButton.bottomAnchor.constraint(equalTo: dotButton.bottomAnchor).isActive = true
            } else {
                operationButton.bottomAnchor.constraint(equalTo: previousButton!.topAnchor).isActive = true
            }
            operationButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            previousButton = operationButton
        }
        
        let percentButton = UIButton(frame: .zero)
        percentButton.setTitleColor(.black, for: .normal)
        percentButton.backgroundColor = .lightGray
        percentButton.setTitle("%", for: .normal)
        percentButton.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
        percentButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.addSubview(percentButton)
        percentButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 1/4, constant: 0).isActive = true
        percentButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 1/5, constant: 0).isActive = true
        percentButton.rightAnchor.constraint(equalTo: previousButton!.leftAnchor).isActive = true
        percentButton.topAnchor.constraint(equalTo: previousButton!.topAnchor).isActive = true
        percentButton.addTarget(self, action: #selector(percentPress(_:)), for: .touchUpInside)
        percentButton.layer.borderWidth = 2
        percentButton.layer.borderColor = UIColor.black.cgColor
        
        let changeSignalButton = UIButton(frame: .zero)
        changeSignalButton.setTitleColor(.black, for: .normal)
        changeSignalButton.backgroundColor = .lightGray
        changeSignalButton.setTitle("+/-", for: .normal)
        changeSignalButton.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
        changeSignalButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.addSubview(changeSignalButton)
        changeSignalButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 1/4, constant: 0).isActive = true
        changeSignalButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 1/5, constant: 0).isActive = true
        changeSignalButton.rightAnchor.constraint(equalTo: percentButton.leftAnchor).isActive = true
        changeSignalButton.topAnchor.constraint(equalTo: percentButton.topAnchor).isActive = true
        changeSignalButton.addTarget(self, action: #selector(changeSign(_:)), for: .touchUpInside)
        changeSignalButton.layer.borderWidth = 2
        changeSignalButton.layer.borderColor = UIColor.black.cgColor
        
        let clearButton = UIButton(frame: .zero)
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .lightGray
        clearButton.setTitle("AC", for: .normal)
        clearButton.titleLabel?.font = UIFont(name: "Helvetica", size: fontSize)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.addSubview(clearButton)
        clearButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 1/4, constant: 0).isActive = true
        clearButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 1/5, constant: 0).isActive = true
        clearButton.rightAnchor.constraint(equalTo: changeSignalButton.leftAnchor).isActive = true
        clearButton.topAnchor.constraint(equalTo: changeSignalButton.topAnchor).isActive = true
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        clearButton.layer.borderWidth = 2
        clearButton.layer.borderColor = UIColor.black.cgColor
        
    }
    
    func buildViewHierarchy() {
        addSubview(topView)
        addSubview(bottomView)
        
        topView.addSubview(resultLabel)
        setupNumpad()
    }
    
    func setupConstraints() {
        topView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2/7, constant: 0.0).isActive = true
        
        bottomView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 5/7, constant: 0.0).isActive = true
        
        resultLabel.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor).isActive = true
        resultLabel.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -5).isActive = true
        resultLabel.bottomAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: -20).isActive = true
        resultLabel.heightAnchor.constraint(equalTo: self.topView.heightAnchor, multiplier: 1/2, constant: 0.0).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .black
    }
    
}
