//
//  CategorySelectionViewController.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol CategorySelectionView: class {
    
    func displayCategories(_ categories: [String])
    
}

class CategorySelectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CategorySelectionPresenter!
    
    var cellModels: [CategoryCellViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: MainButton) {
        presenter.saveSelectedCategory()
    }
}

extension CategorySelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>)
        let viewModel = cellModels[indexPath.row]
        
    }
}

extension CategorySelectionViewController: UITableViewDelegate {
    
    
}

private extension CategorySelectionViewController {
    
    
}

