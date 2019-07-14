//
//  WelcomeViewController.swift
//  Swappy
//
//  Created by Mihail on 14/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol WelcomeView: class {
    
    func setStartButtonEnabled(_ isStartEnabled: Bool)
    func displayCity(_ cityText: String)
}

final class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: WelcomePresenter!
    
    @IBOutlet weak var nameTextField: AppTextField!
    @IBOutlet weak var cityTextField: AppTextField!
    @IBOutlet weak var startButton: MainButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
    }
}

// MARK: - WelcomeView

extension WelcomeViewController: WelcomeView {
    
    func setStartButtonEnabled(_ isStartEnabled: Bool) {
        startButton.isEnabled = isStartEnabled
    }
    
    func displayCity(_ cityText: String) {
        cityTextField.text = cityText
    }
}

// MARK: - UITextFieldDelgate

extension WelcomeViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == cityTextField {
            presenter.openCitySelection()
            return false
        }
        
        return true
    }
}

private extension WelcomeViewController {
    
    func setupTextFields() {
        nameTextField.delegate = self
        cityTextField.delegate = self
    }
}
