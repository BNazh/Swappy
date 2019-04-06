//
//  UITextField+DoneToolbar.swift
//  Swappy
//
//  Created by Mihail on 06/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addDoneToolbar() {
        let selector = #selector(toolbarDoneClicked)
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: selector)
        
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let toolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        toolbar.setItems([flexibleSpaceItem, doneButton], animated: false)
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    @objc
    func toolbarDoneClicked() {
        endEditing(true)
    }
}
