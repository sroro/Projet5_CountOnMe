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
        NotificationCenter.default.addObserver(self, selector: #selector(displayError), name: Notification.Name("error"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayError2), name: Notification.Name("error2"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayError3), name: Notification.Name("error3"), object: nil)
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

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
        calcul.equal()
    }
    
    
    @objc func updateText() {
        textView.text = calcul.calculString
    }
    
    @objc func displayError(){
        let messsage = "Un operateur est déja mis !"
        let alertVC = UIAlertController(title: "Zéro!", message: messsage, preferredStyle: .alert)
                  alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                  self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func displayError2(){
          let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
                     alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                     return self.present(alertVC, animated: true, completion: nil)
       }
    @objc func displayError3(){
           let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
           alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           return self.present(alertVC, animated: true, completion: nil)
       }
    

}

