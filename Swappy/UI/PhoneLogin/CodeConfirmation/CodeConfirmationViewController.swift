//
//  CodeConfirmationViewController.swift
//  Swappy
//
//  Created by Mihail on 21/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import InputMask

protocol CodeConfirmationView: class, ErrorView, LoadingView {
    func openMainScreeen()
    func displayInfo(infoString: NSAttributedString)
}

final class CodeConfirmationViewController: UIViewController {
    
    var presenter: CodeConfirmationPresenter!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var confirmCodeButton: MainButton!
    @IBOutlet weak var codeTextField: AppTextField!
    @IBOutlet var textFieldDelegate: MaskedTextFieldDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem?.title = ""
        
        codeTextField.delegate = textFieldDelegate
        textFieldDelegate.listener = self
        
        presenter.showInfo()
    }
    
    @IBAction func confirmCodeTapped(_ sender: UIButton) {
        let code = codeTextField.text ?? ""
        presenter.authenticate(with: code)
    }
    
    @IBAction func getNewConfirmationCodeTapped(_ sender: UIButton) {
        presenter.getNewConfirmationCode()
    }
}

extension CodeConfirmationViewController: CodeConfirmationView {
    
    func openMainScreeen() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func displayInfo(infoString: NSAttributedString) {
        infoLabel.attributedText = infoString
    }
}

extension CodeConfirmationViewController: MaskedTextFieldDelegateListener {
    
    func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
        confirmCodeButton.isEnabled = complete
    }
}
