//
//  SignInViewController.swift
//  myRecipes
//
//  Created by Pamela Lim on 9/5/23.
//

import UIKit
import Foundation

class SignInViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Add target to signInButton to trigger signInButtonTapped(_:)
        signIn.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        // Perform sign-in logic here
        
        guard let username = username.text, !username.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter yuor username.")
            return
        }
        
        guard let email = email.text, !email.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter your username.")
            return
        }
    
        guard let password = password.text, !password.isEmpty else {
            showAlert(withTitle: "Error", message: "Please enter your password.")
            return
        }
    
        // Validate the username and password
        if validateCredentials(username: username, email: email, password: password) {
            // Successful sign-in
            showAlert(withTitle: "Success", message: "Sign-in successful!")
            // Navigate to the next screen or perform any necessary actions
        } else {
            // Failed sign-in
            showAlert(withTitle: "Error", message: "Invalid username or password.")
        }
    }

    func validateCredentials(username: String, email: String, password: String) -> Bool {
        let validUsername = "myusername"
        let validEmail = "myemail"
        let validPassword = "mypassword"
        
        return username == validUsername && email == validEmail && password == validPassword
        
     /*   // Make a request to authentication service or backend API for validation
        Dictionary().authenticate(username: username, password: password) { result in
            // Hide the loading indicator or enable UI    }*/
    }

    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
