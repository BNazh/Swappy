//
//  StartViewController.swift
//  Swappy
//
//  Created by Mihail on 22/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol StartView: class {
    func stopLoading()
    func showError()
}

final class StartViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: StartPresenter!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData() {
        activityIndicator.startAnimating()
        presenter.loadStartData()
    }
}

extension StartViewController: StartView {
    
    func showError() {
        let title = "Ошибка"
        let message = "Не удалось загрузить данные, необходимые для начала работы в приложении."
        let actionTitle = "Повторить"
        
        let repeateAction = UIAlertAction(title: actionTitle, style: .default) { [weak self] _ in
            self?.loadData()
        }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(repeateAction)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
}
