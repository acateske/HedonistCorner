//
//  AgeNumberViewController.swift
//  HedonistCorner
//
//  Created by Aleksandar Tesanovic on 7/17/18.
//  Copyright © 2018 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class AgeNumberViewController: UIViewController {

//MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ageNumberTextField: UITextField! 
    @IBOutlet weak var confirmButton: UIButton! {
        didSet {
            confirmButton.layer.cornerRadius = K.cornerRadius
        }
    }
    @IBOutlet weak var detailView: UIView! {
        didSet {
            detailView.isHidden = true
            detailView.layer.cornerRadius = K.cornerRadius
        }
    }
    
//MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        ageNumberTextField.delegate = self
        ageNumberTextField.keyboardType = .numberPad
    }

//MARK: Methods
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if ageNumberTextField.text!.isEmpty {
            detailView.isHidden = true
            handleAge()
            return false
        } else {
            if let number = Int(ageNumberTextField.text!), number > 17 {
                detailView.isHidden = true
                return super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
            } else {
                detailView.isHidden = false
            }
        }
        return false
    }
    
    private func updateUI() {
        let title = K.Names.appName
        titleLabel.text = ""
        var charIndex = 0.0
        for letter in title {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    private func handleAge() {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Age number!", message: "How old are you?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] (action) in
            guard let self = self else {return}
            
            if let textNumber = textField.text {
                if let number = Int(textNumber) {
                    if number > 17 {
                        self.performSegue(withIdentifier: K.Seque.startSeque, sender: self)
                    } else {
                        self.detailView.isHidden = false
                    }
                }
            }
        }))
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = K.PlaceholderNames.addYourAge
            textField = alertTextField
        }
        alert.textFields?.first?.keyboardType = .numberPad
        present(alert, animated: true)
    }
}

//MARK: - UITextFieldDelegate Methods

extension AgeNumberViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
