//
//  addPhotoViewController.swift
//  myRecipes
//
//  Created by Saihej Bhangu on 25/5/2023.
//

import Foundation
import UIKit

class addPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var profilePhotoImgView: UIImageView!
    
    @IBOutlet weak var uploadPhotoBtn: UIButton!
    
    @IBOutlet weak var finishBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profilePhotoImgView.layer.cornerRadius = profilePhotoImgView.frame.size.width / 2
        profilePhotoImgView.clipsToBounds = true
        
        // Set constraints for the image view
        profilePhotoImgView.contentMode = .scaleAspectFill
        profilePhotoImgView.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoImgView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profilePhotoImgView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        profilePhotoImgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 240).isActive = true
     profilePhotoImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -1).isActive = true
        
    }
    
    
    //Upload Photo Btn tapped
    @IBAction func uploadPhotoBtnTapped(_ sender: UIButton) {
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
    
    
}

