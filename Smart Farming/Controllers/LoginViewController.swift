//
//  ViewController.swift
//  Smart Farming
//
//  Created by Riya Gupta on 27/04/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginLabel: UIButton!
    @IBOutlet weak var newAccountLabel: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        titleLabel.text = ""
                var charIndex = 0.0
                let titleText = "Welcome Back!"
                for letter in titleText {
                    Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                        self.titleLabel.text?.append(letter)
                    }
                    charIndex += 1
                }
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.showAlert(textString: "Wrong Email or Password.")
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                }
            }
        }

        if emailTextField.text == "" && passwordTextField.text == "" {
            showAlert(textString: "Enter Email and Password")
        } else if emailTextField.text != "" && passwordTextField.text == "" {
            showAlert(textString: "Enter Password")
        } else if emailTextField.text == "" && passwordTextField.text != "" {
            showAlert(textString: "Enter Email")
        }
    }
    
    func showAlert(textString: String) {
        
            let alert = UIAlertController(title: "Error", message: textString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
                print("Tapped Dismiss")
            }))
            present(alert, animated: true)
        
    }

    @IBAction func newAccountButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "loginToRegister", sender: self)
    }
}
