//
//  ProfileEditViewController.swift
//  Swappy
//
//  Created by Mihail on 25/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProfileEditView: AnyObject {
    
    func displayInitialize()
    func displayCity(_ cityText: String)
    
}

final class ProfileEditViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var avatarImageView: UIButton!
    @IBOutlet weak var nameTextField: AppTextField!
    @IBOutlet weak var phoneTextField: AppTextField!
    @IBOutlet weak var cityTextField: AppTextField!
    
    
    // MARK: - Lifecycle
    
    
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
