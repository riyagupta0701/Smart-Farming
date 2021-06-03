//
//  RegisterViewController.swift
//  Smart Farming
//
//  Created by Riya Gupta on 28/04/21.
//

import UIKit
import Firebase
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet weak var registrationLabel: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registrationButton(_ sender: UIButton) {
        
        if let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let address = addressTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) {
                authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.db.collection(K.FStore.collectionName).document(email).setData([K.FStore.nameField: name, K.FStore.addressField: address]) {
                        (error) in
                        if let e = error {
                            print(e)
                        } else {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
}


