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
    private weak var pickerView: UIPickerView?
    
    private var items: [String] = []
    
    // MARK: - Functions
    
    func setup(textField: UITextField, with items: [String]) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        textField.inputView = pickerView
        textField.inputAccessoryView = createToolBar()
        
        textField.delegate = self
        
        self.textField = textField
        self.items = items
        self.pickerView = pickerView
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

// MARK: - TextfieldDelegate

extension TextFieldPickerDDM: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let itemIndex = items.firstIndex(of: textField.text ?? "") ?? 0
        pickerView?.selectRow(itemIndex, inComponent: 0, animated: true)
        textField.text = items[itemIndex]
    }
}


// MARK: - Private

private extension TextFieldPickerDDM {
    
    func createToolBar() -> UIView {
        let selector = #selector(doneClicked)
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: selector)
        
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let toolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        toolbar.setItems([flexibleSpaceItem, doneButton], animated: false)
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    @objc
    func doneClicked() {
        textField?.endEditing(true)
    }
}
