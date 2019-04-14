//
//  PhoneLoginViewController.swift
//  Swappy
//
//  Created by Mihail on 18/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import InputMask

protocol PhoneLoginView: class, ErrorView, LoadingView {
    
}


final class PhoneLoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: PhoneLoginPresenter!
    
    @IBOutlet weak var verificationButton: MainButton!
    @IBOutlet weak var phoneTextField: AppTextField!
    
    @IBOutlet var textFieldDelegate: MaskedTextFieldDelegate!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        textFieldDelegate.affinityCalculationStrategy = .prefix
        phoneTextField.delegate = textFieldDelegate
        textFieldDelegate.listener = self
        
        phoneTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func sendVerificationCodeTapped(_ sender: UIButton) {
        let phone = phoneTextField.text ?? ""
        presenter.sendVerificationCode(to: phone)
    }
}

extension PhoneLoginViewController: PhoneLoginView {
    
    
}

extension PhoneLoginViewController: MaskedTextFieldDelegateListener {
    
    func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
        verificationButton.isEnabled = complete
    }
}

extension PhoneLoginViewController: AnalyticScreenProvider {
    var screen: AnalyticScreen {
        return .phoneLogin
    }
}
