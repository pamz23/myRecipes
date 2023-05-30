//
//  SignInViewController.swift
//  myRecipes
//
//  Created by Pamela Lim on 9/5/23.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signIn: UIButton!

    var currentUser: User?
    
    
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
//         Check if all fields are filled
//        guard let username = username.text, !username.isEmpty else {
//            showAlert(withTitle: "Error", message: "Please enter your username.")
//            return
//        }
//        guard let email = email.text, !email.isEmpty else {
//            showAlert(withTitle: "Error", message: "Please enter your email.")
//            return
//        }
//        guard let password = password.text, !password.isEmpty else {
//            showAlert(withTitle: "Error", message: "Please enter your password.")
//            return
//        }

        let username = username.text
        let email = email.text
        let password = password.text

        // Validate the credentials
        if validateCredentials(username: username!, email: email!, password: password!) {
            // Successful sign-in
            print("HEre")
            CurrentUser.shared.currentUser = currentUser
            performSegue(withIdentifier: "segueFromSignInToMain", sender: self)
        } else {
            print("This")
            // Failed sign-in
            showAlert(withTitle: "Error", message: "Invalid username, email, or password.")
        }
    }

    // Validates the credentials for all text fields
    func validateCredentials(username: String, email: String, password: String) -> Bool {
        // Retrieve the stored user credentials from UserDefaults
        if let data = UserDefaults.standard.data(forKey: "credentials"),
            let storedUsers = try? PropertyListDecoder().decode([User].self, from: data) {
            let credentials = User(username: username, email: email, password: password)
            // Check if the entered credentials match any stored user
            print("Store User \(storedUsers)")
            print("Credentials \(credentials)")
            for user in storedUsers{
                if user.email == credentials.email, user.password == credentials.password{
                    currentUser = credentials
                    return true
                }
            }
        }
        return false
    }

    // Function to display an alert with title and message to the user
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    // Creating segue to print username in nameLabel
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToSettingB" {
//            if let dest = segue.destination as? settingViewController {
//                dest.currentUser = currentUser
//            }
//        }
//    }
}
