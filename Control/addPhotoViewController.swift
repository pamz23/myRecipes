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
        profilePhotoImgView.widthAnchor.constraint(equalToConstant: 230).isActive = true
        profilePhotoImgView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        profilePhotoImgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90).isActive = true
     profilePhotoImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        
        finishBtn.isEnabled = false
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
               // Instantiate the settingViewController from the storyboard
               let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your actual storyboard name
               if let settingVC = storyboard.instantiateViewController(withIdentifier: "settingViewController") as? settingViewController {
                   settingVC.selectedPhoto = selectedImage
                   self.present(settingVC, animated: true, completion: nil)
               }
           }
        
        picker.dismiss(animated: true, completion: nil)
        finishBtn.isEnabled = true
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToSettings" {
                if let selectedImage = sender as? UIImage,
                   let destinationVC = segue.destination as? settingViewController {
                    destinationVC.selectedPhoto = selectedImage
                }
            }
        }
    
    
}

