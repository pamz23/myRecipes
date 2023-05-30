//
//  SignUpViewController.swift
//  myRecipes
//
//  Created by Stine Juhl on 9/5/2023.
//

import UIKit
import Foundation

struct User: Codable {
    var username: String
    var email: String
    var password: String
}

class SignUpViewController: UIViewController {

    @IBOutlet weak var yourName: UITextField!
    @IBOutlet weak var yourEmail: UITextField!
    @IBOutlet weak var youPassword: UITextField!
    @IBOutlet weak var signUp: UIButton!

    var users: [[String: String]] = []

    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailCheck = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailCheck.evaluate(with: email)
    }
    func isUsernameTaken(_ username: String) -> Bool {
        if let data = UserDefaults.standard.data(forKey: "credentials") {
            if let credentials = try? PropertyListDecoder().decode([User].self, from: data) {
                return credentials.contains { $0.username == username }
            }
        }
        return false
    }
    
    func isEmailUsed(_ email: String) -> Bool {
        if let data = UserDefaults.standard.data(forKey: "credentials") {
            if let credentials = try? PropertyListDecoder().decode([User].self, from: data) {
                return credentials.contains { $0.email == email }
            }
        }
        return false
    }

    func performSignup(with username: String, email: String, password: String) {
//        let user: [String: String] = [
//            "name": username,
//            "email": email,
//            "password": password
//        ]
        CurrentUser.shared.currentUser = User(username: username, email: email, password: password)

        
        // Your signup logic here
        // This is where you would typically make an API call to register the user
        if let data = UserDefaults.standard.data(forKey: "credentials") {
            if var credentials = try? PropertyListDecoder().decode([User].self, from: data) {
                credentials.append(User(username: username, email: email, password: password))
                let encodedData = try? PropertyListEncoder().encode(credentials)
                UserDefaults.standard.set(encodedData, forKey: "credentials")
                UserDefaults.standard.set(false, forKey: "setup_\(username)")
                // Perform the segue after the data is stored
                let alert = UIAlertController(title: "Congratulation!", message: "Registered succesfully!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.performSegue(withIdentifier: "segueFromSignUpToMain", sender: self)
                }))
                present(alert, animated: true, completion: nil)
                
            }
        } else {
            let credentials = [User(username: username, email: email, password: password)]
            let encodedData = try? PropertyListEncoder().encode(credentials)
            UserDefaults.standard.set(encodedData, forKey: "credentials")

            // Perform the segue after the data is stored
            let alert = UIAlertController(title: "Congratulation!", message: "Registered succesfully!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.performSegue(withIdentifier: "segueFromSignUpToMain", sender: self)
            }))
            present(alert, animated: true, completion: nil)
        }

        // Show success message
        print("Sign up was successful")
    }

    @IBAction func signupButtonTapped(_: UIButton) {
        // Check if all fields are filled
        guard let username = yourName.text,
            let email = yourEmail.text,
            let password = youPassword.text,
            !username.isEmpty,
            !email.isEmpty,
            !password.isEmpty else {
            print("Error, please fill in all the fields")
            return
        }
        if let data = UserDefaults.standard.data(forKey: "credentials") {
            if let credentials = try? PropertyListDecoder().decode([User].self, from: data) {
                print(credentials)
            }
        }
        
        guard !isUsernameTaken(username) else {
            let alert = UIAlertController(title: "Error!", message: "Username already taken!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated:true, completion:nil )
            return
        }
        guard isValidEmail(email) else {
            let alert = UIAlertController(title: "Error!", message: "Please enter valid email!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated:true, completion:nil )
            return
        }
        guard !isEmailUsed(email) else {
            let alert = UIAlertController(title: "Error!", message: "Email aready exist!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated:true, completion:nil )
            return
        }
        // Perform signup process
        performSignup(with: username, email: email, password: password)

    }

    //creating segue to print username in nameLabel
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToMain" {
//            if let dest = segue.destination as? settingViewController {
//                dest.nameLabel.text = yourName.text
//            }
//        }
//    }
//
//    @IBAction func goToDestination(_ sender: UITextField) {
//        performSegue(withIdentifier: "goToMain", sender: self)
//    }
}
