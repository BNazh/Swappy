//
//  CategoryPickerDDM.swift
//  Swappy
//
//  Created by Mihail on 25/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class TextFieldPickerDDM: NSObject {
    
    // MARK: - Properties
    
    private weak var textField: UITextField?
    
    private var items: [String] = []
    
    // MARK: - Functions
    
    func setup(textField: UITextField, with items: [String]) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        textField.inputView = pickerView
        
        self.textField = textField
        self.items = items
    }
}

// MARK: DataSource

extension TextFieldPickerDDM: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
}

// MARK: - Delegate

extension TextFieldPickerDDM: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField?.text = items[row]
    }
}
