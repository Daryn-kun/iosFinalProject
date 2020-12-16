//
//  EditViewController.swift
//  FinalProject
//
//  Created by nagato on 12/15/20.
//  Copyright © 2020 nagato. All rights reserved.
//

import UIKit
import ContactsUI
import RealmSwift

class EditViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumLbl: UILabel!
    @IBOutlet weak var addImgBtn: UIButton!
    let contactsController = CNContactPickerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = realm.object(ofType: User.self, forPrimaryKey: 0)
        self.emailTextField.text = user!.userEmail
        self.fullNameTextField.text = user!.fullName
        if(user?.userImg != nil){
            let image : UIImage = UIImage(data: user!.userImg! as Data)!
            self.profileImageView.image = image
        }
        if (user?.userContact != nil){
            self.phoneNumLbl.text = user?.userContact
        }
        addImgBtn.layer.cornerRadius = 10.0
        addImgBtn.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 10.0
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.shadowRadius = 10.0
        emailTextField.layer.shadowOpacity = 0.3
        emailTextField.layer.shadowOffset = CGSize(width: 5, height: 8)
        emailTextField.clipsToBounds = false
        fullNameTextField.layer.cornerRadius = 10.0
        fullNameTextField.layer.masksToBounds = true
        fullNameTextField.layer.shadowRadius = 10.0
        fullNameTextField.layer.shadowOpacity = 0.3
        fullNameTextField.layer.shadowOffset = CGSize(width: 5, height: 8)
        fullNameTextField.clipsToBounds = false
        
    }
    
    @IBAction func addImageBtnTapped(_ sender: Any) {
        showImagePickerControllerActionSheet()
    }
    @IBAction func addNumBtnTapped(_ sender: Any) {
        contactsController.delegate = self
        self.present(contactsController, animated: true, completion: nil)
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        let myProfile = User()
        myProfile.userContact = phoneNumLbl.text
        let data = NSData(data: profileImageView.image!.jpegData(compressionQuality: 0.9)!)
        myProfile.userImg = data
        myProfile.fullName = fullNameTextField.text
        myProfile.userEmail = emailTextField.text
        myProfile.id = 0
        try! realm.write{
            realm.add(myProfile, update: .modified)
        }
        navigationController?.popViewController(animated: true)
    }
    
}
extension EditViewController: CNContactPickerDelegate{
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let userPhoneNumbers:[CNLabeledValue<CNPhoneNumber>] = contact.phoneNumbers
        let firstPhoneNumber:CNPhoneNumber = userPhoneNumbers[0].value

        // user phone number string
        self.phoneNumLbl.text = firstPhoneNumber.stringValue
    }
}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func showImagePickerControllerActionSheet(){
        let photoLibraryAction = UIAlertAction(title: "Choose from Gallery", style: .default){ (action)
            in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take a Photo", style: .default){ (action)
            in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        AlertService.showAlert(style: .actionSheet, title: "Choose your image", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    func showImagePickerController(sourceType: UIImagePickerController.SourceType){
        let image = UIImagePickerController()
        image.delegate = self
        image.allowsEditing = true
        image.sourceType = sourceType
        present(image, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.profileImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.profileImageView.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
