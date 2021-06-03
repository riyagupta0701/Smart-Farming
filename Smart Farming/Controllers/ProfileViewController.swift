//
//  ProfileViewController.swift
//  Smart Farming
//
//  Created by Riya Gupta on 28/04/21.
//

import UIKit
import Firebase
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var backLabel: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadProfile()
    }
    
    func loadProfile() {
        
//        self.db.collection(K.FStore.collectionName).getDocuments { (querySnapshot, error) in
//            if let e = error {
//                print(e)
//            } else {
//                if let snapshotDocuments = querySnapshot?.documents {
//                    for doc in snapshotDocuments {
//                        let data = doc.data()
//                        if let name = data[K.FStore.nameField] as? String, let address = data[K.FStore.addressField] as? String {
//                            self.nameLabel.text = name
//                            self.emailLabel.text = Auth.auth().currentUser?.email
//                            self.addressLabel.text = address
//                        }
//                    }
//                }
//            }
//        }
        
        let docRef = db.collection(K.FStore.collectionName).document((Auth.auth().currentUser?.email)!)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let nameProperty = document.get("name")
                let addressProperty = document.get("address")
                self.nameLabel.text = nameProperty as? String
                self.emailLabel.text = Auth.auth().currentUser?.email
                self.addressLabel.text = addressProperty as? String
            } else {
                print("Document does not exist")
            }
        }

    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
