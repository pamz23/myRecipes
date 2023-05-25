//
//  settingViewController.swift
//  myRecipes
//
//  Created by Saihej Bhangu on 21/5/2023.
//


import Foundation
import UIKit

class settingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePhotoImgView: UIImageView!
    @IBOutlet weak var changeNameBtn: UIButton!
    @IBOutlet weak var changePhotoBtn: UIButton!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    var name: String = "Jane's Profile"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateNameLabel()
        
        // Make the profile photo view circular
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
    
    private func updateNameLabel() {
            nameLabel.text = name
        }
    
    @IBAction func changeNameBtnTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Change Name", message: "Enter your new name", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "New Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first,
                  let newName = textField.text,
                  !newName.isEmpty else {
                return
            }
            
            self?.name = newName
            self?.updateNameLabel()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
                
        present(alertController, animated: true, completion: nil)
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
    
    //dark mode toggle
    @IBAction func darkModeSwitchToggled(_ sender: UISwitch) {
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
    
    
  


