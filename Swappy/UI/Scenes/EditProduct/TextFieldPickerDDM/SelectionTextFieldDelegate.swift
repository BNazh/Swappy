//
//  SelectionTextFieldDelegate.swift
//  Swappy
//
//  Created by Mihail on 14/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class SelectionTextFieldDelegate: NSObject {
    
    func setup(textField: UITextField) {
        textField.delegate = self
    }
}

extension SelectionTextFieldDelegate: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
