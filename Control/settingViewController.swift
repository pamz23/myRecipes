//
//  settingViewController.swift
//  myRecipes
//
//  Created by Saihej Bhangu on 21/5/2023.
//


import Foundation
import UIKit

class settingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profilePhotoImgView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func changePhotoBtnTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profilePhotoImgView.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func darkModeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            if let window = UIApplication.shared.windows.first {
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
            if let window = UIApplication.shared.windows.first {
                window.overrideUserInterfaceStyle = .light
            }
        }
        
    }
    
    
  
}

