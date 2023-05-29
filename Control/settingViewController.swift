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
    
    var username: String?
    var selectedPhoto: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateNameLabel()
        formatProfilePhotoImgView()
    }
    
    private func formatProfilePhotoImgView()
    {
        //load in placeholder image and display it in the Image View until the user uploads their profile photo
        let placeholderImage = UIImage(named: "placeholder_image")
        profilePhotoImgView.image = placeholderImage
 
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
        if let username = username {
                    nameLabel.text = username //update nameLabel with username that was entered during SignUp/SignIn process
                }
        }
    
    @IBAction func changeNameBtnTapped(_ sender: UIButton) { //If the changeName button is tapped, display an alert text field where the user can enter and save thier new name.
        let alertController = UIAlertController(title: "Change Name", message: "Enter your new name", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "New Name" //show Alert
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first,
                  let newName = textField.text, //Save whatever is entered in textfield as newName.
                  !newName.isEmpty else {
                return
            }
            
            self?.username = newName
            self?.updateNameLabel() //update nameLabel to show the new name.
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction) //if the cancel button is pressed instead of save, cancel the action entirely.
                
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func changePhotoBtnTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil) //if the changePhoto button is pressed, run the imagePicker function, which allows the user to select a photo from the iPhone's gallery.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profilePhotoImgView.image = selectedImage //replace imageView with selected image from gallery.
            changePhotoBtn.setTitle("Change your Photo", for: .normal)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil) //if the cancel button is pressed instead of save, cancel the action entirely.
    }
    
    //Dark mode toggle - depending on the value of the UISwitch, either toggle dark/light theme application wide. 
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
    
    
  


