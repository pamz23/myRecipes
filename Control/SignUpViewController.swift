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
    @IBAction func signUp(_ sender: Any) {
    }
}

