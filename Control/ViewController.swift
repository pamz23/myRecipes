//
//  ViewController.swift
//  myRecipes
//
//  Created by Pamela Lim on 2/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    //declaring properties
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    //overriding the method from the UIViewController class
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
}

