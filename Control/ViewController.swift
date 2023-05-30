//
//  ViewController.swift
//  myRecipes
//
//  Created by Pamela Lim on 2/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    //Outlets for Buttons
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide back button on viewController
        navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
}

