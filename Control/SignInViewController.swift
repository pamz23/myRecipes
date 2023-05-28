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
        
        // Disable the sign-in button initially
        signIn.isEnabled = false
        
        // Add target actions for text fields to handle editing changes
        username.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        email.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        signIn.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)
    }
    
    // Handle editing changes in text fields
        @objc func textFieldDidChange(_ textField: UITextField) {
            // Check if all fields have values
            let username = username.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let email = email.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let password = password.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

            // Enable the sign-in button only if all fields have non-empty values
            signIn.isEnabled = !username.isEmpty && !email.isEmpty && !password.isEmpty
        }
    
    // Action for sign-in button
    
    @IBAction func signInButtonTapped(_: UIButton) {
 
        //checks if username textfield is empty
            guard let username = username.text, !username.isEmpty else {
                showAlert(withTitle: "Error", message: "Please enter your username.")
                return
            }
            //checks if email textfield is empty
            guard let email = email.text, !email.isEmpty else {
                showAlert(withTitle: "Error", message: "Please enter your email.")
                return
            }
            //checks if password textfield is empty
            guard let password = password.text, !password.isEmpty else {
                showAlert(withTitle: "Error", message: "Please enter your password.")
                return
            }

            // Validate the username, email, and password
            if validateCredentials(username: username, email: email, password: password) {
                // Successful sign-in

                performSegue(withIdentifier: "SegueToRecipeListingA", sender: self) //Manual Segue
                // Navigate to the next screen or perform any necessary actions
                
            } else {
                // Failed sign-in
                showAlert(withTitle: "Error", message: "Invalid username, email, or password.")
            }
    }

    //validates the credentials for all texifields
    func validateCredentials(username: String, email: String, password: String) -> Bool {
        // Validate username
        if username.isEmpty {
            return false
        }
           
        // Validate email - the email must contain "@" and "."
        if !email.contains("@") || !email.contains(".") {
            return false
        }
           
        // Validate password - checks if the password has at least 6 characters
        if password.count < 6 {
            return false
        }
           
        // If all validation checks pass, return true
        return true
    }
 

    //function to display of alert with title and message to the user
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //creating segue to print username in nameLabel
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettingB" {
            if let dest = segue.destination as? settingViewController {
                dest.nameLabel.text = username.text
            }
        }
    }
    
    @IBAction func goToDestination(_ sender: UITextField) {
        performSegue(withIdentifier: "goToSettingB", sender: self)
    }
}
