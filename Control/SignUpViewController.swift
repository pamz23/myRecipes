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
        guard  let username = yourName.text,
               let email = yourEmail.text,
               let password = youPassword.text,
               !username.isEmpty,
               !email.isEmpty,
               !password.isEmpty else {
            print("Error, please fill in all the fields")
            return
        }
        
        // Perform signup process
        performSignup(with: username, email: email, password: password)
    }
    
    func performSignup(with username: String, email: String, password: String) {
        // Your signup logic here
        // This is where you would typically make an API call to register the user
        
        
        // Show success message
        print("Sign up was successful")
    }
}
