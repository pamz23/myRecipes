//
//  SignUpViewController.swift
//  myRecipes
//
//  Created by Stine Juhl on 9/5/2023.
//

import UIKit
import Foundation

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var yourName: UITextField!
    @IBOutlet weak var yourEmail: UITextField!
    @IBOutlet weak var youPassword: UITextField!
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        // Check if all fields are filled
        guard  let name = yourName.text,
               let email = yourEmail.text,
               let password = youPassword.text,
               !name.isEmpty,
               !email.isEmpty,
               !password.isEmpty else {
            print("Error, please fill in all the fields")
            return
        }
        
        // Perform signup process
        performSignup(with: name, email: email, password: password)
    }
    
    func performSignup(with name: String, email: String, password: String) {
        // Your signup logic here
        // This is where you would typically make an API call to register the user
        
        
        // Show success message
        print("Sign up was successful")
    }
        
        func showAlert(with title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
}
