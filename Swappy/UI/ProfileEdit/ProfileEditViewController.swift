//
//  ProfileEditViewController.swift
//  Swappy
//
//  Created by Mihail on 25/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProfileEditView: AnyObject {
    
    var name: String { get }
    var phone: String { get }
    var city: String { get set }
    
    func reloadSaveButton(isEnabled: Bool)
    func displayInitialize(name: String, phone: String, city: String)
}

final class ProfileEditViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: ProfileEditPresenter!
    
    @IBOutlet weak var avatarImageView: UIButton!
    @IBOutlet weak var nameTextField: AppTextField!
    @IBOutlet weak var phoneTextField: AppTextField!
    @IBOutlet weak var cityTextField: AppTextField!
    
    @IBOutlet weak var saveButton: MainButton!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.initialize()
    }
    
    // MARK: - Actions
    
    @IBAction func savePressed(_ sender: Any) {
        presenter.save()
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        presenter.logout()
    }
}

// MARK: - ProfileEditView

extension ProfileEditViewController: ProfileEditView {
    
    var name: String {
        return nameTextField.text ?? ""
    }
    
    var phone: String {
        return phoneTextField.text ?? ""
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
            phoneTextField.becomeFirstResponder()
        }
        
        if textField == phoneTextField {
            cityTextField.becomeFirstResponder()
        }
        
        return true
    }
}
