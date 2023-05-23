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
    
    var users: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Disable the sign-up button initially
            signUp.isEnabled = false

        // Add target actions for text fields to handle editing changes
        yourName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        yourEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        youPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // Handle editing changes in text fields
        @objc func textFieldDidChange(_: UITextField) {
            // Check if all fields have values
            let name = yourName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let email = yourEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let password = youPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

            // Enable the sign-up button only if all fields have non-empty values
            signUp.isEnabled = !name.isEmpty && !email.isEmpty && !password.isEmpty
        }
    
    // Function to check if a user with a specific username, email, or password exists in the dictionary
    func isUserExists(name: String?, email: String?, password: String?) -> Bool {
        for user in users {
            if let nameToCheck = name, let userName = user["name"], nameToCheck == userName {
                return true
            }
            if let emailToCheck = email, let userEmail = user["email"], emailToCheck == userEmail {
                return true
            }
            if let passwordToCheck = password, let userPassword = user["password"], passwordToCheck == userPassword {
                return true
            }
        }
        return false
    }

    func performSignup(with username: String, email: String, password: String) {
        let user:[String: String] = [
        "name": username,
        "email": email,
        "password": password
        ]
        
        users.append(user)

        print("User registered successfully")
        // Your signup logic here
        // This is where you would typically make an API call to register the user
        
        
        // Show success message
        print("Sign up was successful")
    }
    
    @IBAction func signupButtonTapped(_: UIButton) {
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
}
