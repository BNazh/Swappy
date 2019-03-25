//
//  AddProductViewController.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol EditProductView: class, LoadingView, ErrorView {
    
    func showProduct(viewModel: EditProductViewModel)
}

final class EditProductViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: EditProductPresenter!
    
    @IBOutlet weak var nameTextField: AppTextField!
    @IBOutlet weak var descriptionTextField: AppTextField!
    @IBOutlet weak var sizeTextField: AppTextField!
    @IBOutlet weak var priceTextField: AppTextField!
    @IBOutlet weak var contactInfoTextField: AppTextField!
    @IBOutlet weak var categoryTextField: AppTextField!
    @IBOutlet weak var photosHeightConstraint: NSLayoutConstraint!
    
    weak var photosViewController: PhotosViewController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = presenter.screenTitle
        setupPhotosHeight()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        photosViewController = segue.destination as? PhotosViewController
    }
    
    // MARK: - Actions
    
    @IBAction func createProductTapped(_ sender: UIButton) {
        let productRO = productRequestObject
        presenter.createProduct(productRO)
    }
}

extension EditProductViewController: EditProductView {
    
    func showProduct(viewModel: EditProductViewModel) {
        nameTextField.text = viewModel.title
        descriptionTextField.text = viewModel.description
        sizeTextField.text = viewModel.size
        priceTextField.text = viewModel.price
        contactInfoTextField.text = viewModel.contactInfo
        categoryTextField.text = viewModel.category
    }
}

private extension EditProductViewController {
    
    var productRequestObject: ProductRO {
        let urls = photosViewController?.cells.compactMap { $0.url }
        
        return ProductRO(
            images: urls ?? [],
            size: sizeTextField.text ?? "",
            name: nameTextField.text ?? "",
            description: descriptionTextField.text ?? "",
            price: .init(rubles: priceTextField.text ?? ""),
            city: categoryTextField.text ?? "",
            contactPhone: contactInfoTextField.text ?? ""
        )
    }
    
    func setupPhotosHeight() {
        let layout = photosViewController?.collectionView?.collectionViewLayout
        guard let contentHeight = layout?.collectionViewContentSize.height else {
            return
        }
        
        photosHeightConstraint.constant = contentHeight
        photosViewController?.collectionView.layoutIfNeeded()
    }
}
