//
//  ViewController.swift
//  myRecipes
//
//  Created by Pamela Lim on 2/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
}

