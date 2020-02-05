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
    
    var calcul = Calculator()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateText), name: Notification.Name("updateCalcul"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayError(_:)), name: Notification.Name("error"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
                   return
        }
        calcul.addNumber(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calcul.addOperattor(" + ")
        
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calcul.addOperattor(" - ")
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
           calcul.addOperattor(" * ")
       }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
               calcul.addOperattor(" / ")
           }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calcul.equal()
    }
    
    
    @IBAction func tappedResetButton(_ sender: UIButton) {
        calcul.calculString = ""
    }
    
   
    
    @objc func updateText() {
        textView.text = calcul.calculString
    }
    
    // same alerte with title and message as parameter
       func alert(_ message: String) {
           let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
           alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           present(alertVC, animated: true, completion: nil)
       }
    
    @objc func displayError(_ notif:Notification)  {
        if let message = notif.userInfo?["message"] as? String {
            alert(message)
        }else{
            alert("Erreur Inconnue")
        }
        
    }
    

}

