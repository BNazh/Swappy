//
//  CodeConfirmationViewController.swift
//  Swappy
//
//  Created by Mihail on 21/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol CodeConfirmationView: class, ErrorView, LoadingView {
    func openMainScreeen()
}

final class CodeConfirmationViewController: UIViewController {
    
    var presenter: CodeConfirmationPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension CodeConfirmationViewController: CodeConfirmationView {
    
    func openMainScreeen() {
        navigationController?.popToRootViewController(animated: true)
    }
}
