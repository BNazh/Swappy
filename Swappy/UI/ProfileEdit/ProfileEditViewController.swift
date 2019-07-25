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
    func displayInitialize()
}

final class ProfileEditViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: ProfileEditPresenter!
    
    @IBOutlet weak var avatarImageView: UIButton!
    @IBOutlet weak var nameTextField: AppTextField!
    @IBOutlet weak var phoneTextField: AppTextField!
    @IBOutlet weak var cityTextField: AppTextField!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        <#code#>
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
