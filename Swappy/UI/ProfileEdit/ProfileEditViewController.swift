//
//  ProfileEditViewController.swift
//  Swappy
//
//  Created by Mihail on 25/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import InputMask
import BSImagePicker

protocol ProfileEditView: AnyObject, LoadingView, ErrorView {
    
    var name: String { get }
    var city: String { get set }
    
    func reloadSaveButton(isEnabled: Bool)
    func displayInitialize(name: String, phone: String, city: String)
    func displayUpdatedProfile()
}

final class ProfileEditViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: ProfileEditPresenter!
    
    @IBOutlet weak var avatarImageView: UIButton!
    @IBOutlet weak var nameTextField: AppTextField!
    @IBOutlet weak var phoneTextField: AppTextField!
    @IBOutlet var textFieldDelegate: MaskedTextFieldDelegate!
    @IBOutlet weak var cityTextField: AppTextField!
    
    @IBOutlet weak var saveButton: MainButton!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.initialize()
    }
    
    // MARK: - Actions
    
    @IBAction func savePressed(_ sender: Any) {
        let avatar = avatarImageView.imageView?.image
        presenter.save(avatar: avatar)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        presenter.logout()
    }
    
    @IBAction func avatarPressed(_ sender: Any) {
        openAvatarPicker()
    }
}

// MARK: - ProfileEditView

extension ProfileEditViewController: ProfileEditView {
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    var city: String {
        get {
            return cityTextField.text ?? ""
        }
        set {
            cityTextField.text = newValue
        }
    }
    
    func reloadSaveButton(isEnabled: Bool) {
        saveButton.isEnabled = isEnabled
    }
    
    func displayInitialize(name: String, phone: String, city: String) {
        nameTextField.text = name
        phoneTextField.text = phone
        cityTextField.text = city
    }
    
    func displayUpdatedProfile() {
        
    }
}

// MARK: - UITextFieldDelgate

extension ProfileEditViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == cityTextField {
            view.endEditing(true)
            presenter.openCitySelection()
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            cityTextField.becomeFirstResponder()
        }
        
        return true
    }
}

// MARK: - Private

private extension ProfileEditViewController {
    
    func openAvatarPicker() {
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 1
        vc.takePhotos = true
        vc.albumButton.setTitle("Альбом", for: .normal)
        
        bs_presentImagePickerController(vc, animated: true, select: nil, deselect: nil, cancel: nil, finish: { [weak self] assets in
            DispatchQueue.main.async {
                let images = assets.compactMap { $0.image }
                self?.avatarImageView.imageView?.image = images.first
            }
        }, completion: nil)
    }
}
