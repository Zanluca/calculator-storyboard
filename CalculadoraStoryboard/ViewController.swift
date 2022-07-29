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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

