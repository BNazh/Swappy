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
    func close()
}

final class EditProductViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: EditProductPresenter!
    var citiesDDM: TextFieldPickerDDM!
    
    @IBOutlet weak var nameTextField: AppTextField!
    @IBOutlet weak var descriptionTextField: AppTextField!
    @IBOutlet weak var sizeTextField: AppTextField!
    @IBOutlet weak var priceTextField: AppTextField!
    @IBOutlet weak var contactInfoTextField: AppTextField!
    @IBOutlet weak var categoryTextField: AppTextField!
    @IBOutlet weak var cityTextField: AppTextField!
    @IBOutlet weak var photosHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var doneButton: MainButton!
    
    weak var photosViewController: PhotosViewController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem?.title = ""
        
        navigationItem.title = presenter.screenTitle
        doneButton.setTitle(presenter.buttonTitle, for: .normal)
        
        setupPhotosHeight()
        
        setupCitiesTextField()
        setupTextFields()
        
        presenter.initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        photosViewController = segue.destination as? PhotosViewController
    }
    
    // MARK: - Actions
    
    @IBAction func createProductTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        let productRO = productRequestObject
        presenter.performProductAction(productRO: productRO)
    }
}

extension EditProductViewController: EditProductView {
    
    func showProduct(viewModel: EditProductViewModel) {
        photosViewController?.setupImageUrls(viewModel.images)
        
        nameTextField.text = viewModel.title
        descriptionTextField.text = viewModel.description
        sizeTextField.text = viewModel.size
        priceTextField.text = viewModel.price
        contactInfoTextField.text = viewModel.contactInfo
        cityTextField.text = viewModel.city
    }
    
    func close() {
        navigationController?.popViewController(animated: true)
    }
}

extension EditProductViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = self.nextTextField(for: textField) {
            nextTextField.becomeFirstResponder()
        } else {
            createProductTapped(doneButton)
        }
        
        return true
    }
}

// MARK: - Private

private extension EditProductViewController {
    
    var productRequestObject: ProductRO {
        let urls = photosViewController?.cells.compactMap { $0.url }
        
        return ProductRO(
            images: urls ?? [],
            size: sizeTextField.text ?? "",
            name: nameTextField.text ?? "",
            description: descriptionTextField.text ?? "",
            contactPhone: contactInfoTextField.text ?? "",
            priceString: priceTextField.text ?? "",
            city: cityTextField.text ?? ""
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
    
    func setupCitiesTextField() {
        let items = presenter.cityItems
        citiesDDM.setup(textField: cityTextField, with: items)
    }
    
    func setupTextFields() {
        let textFields = [nameTextField, descriptionTextField, sizeTextField, priceTextField, contactInfoTextField]
        for textField in textFields {
            textField?.delegate = self
            textField?.addDoneToolbar()
        }
    }
    
    func nextTextField(for textField: UITextField) -> UITextField? {
        let nextTag = textField.tag + 1
        return view.viewWithTag(nextTag) as? UITextField
    }
}
