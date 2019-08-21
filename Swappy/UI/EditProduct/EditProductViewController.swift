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
    func selectCategory(_ category: String)
    func selectCity(_ city: String)
    func displayReload(hideScrollView: Bool)
    func close()
}

final class EditProductViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: EditProductPresenter!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: AppTextField!
    @IBOutlet weak var descriptionTextField: AppTextField!
    @IBOutlet weak var sizeTextField: AppTextField!
    @IBOutlet weak var priceTextField: AppTextField!
    @IBOutlet weak var contactInfoTextField: AppTextField!
    @IBOutlet weak var cityTextField: AppTextField!
    @IBOutlet weak var categoryTextField: AppTextField!
    
    @IBOutlet weak var photosHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var doneButton: MainButton!
    
    weak var photosViewController: PhotosViewController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.title = presenter.screenTitle
        doneButton.setTitle(presenter.buttonTitle, for: .normal)
        
        setupPhotosHeight()
        setupTextFields()
        
        presenter.initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.reload()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.destination {
        case let vc as PhotosViewController:
            photosViewController = vc
        case let vc as LoginCardViewController:
            vc.isClosable = false
        default:
            break
        }
    }
    
    // MARK: - Actions
    
    @IBAction func createProductTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        let productRO = productRequestObject
        presenter.performProductAction(productRO: productRO)
    }
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        presenter.openCategorySelection()
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
        categoryTextField.text = viewModel.categoryName
    }
    
    func selectCategory(_ category: String) {
        categoryTextField.text = category
    }
    
    func selectCity(_ city: String) {
        cityTextField.text = city
    }
    
    func displayReload(hideScrollView: Bool) {
        scrollView.isHidden = hideScrollView
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
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == categoryTextField {
            view.endEditing(true)
            presenter.openCategorySelection()
            return false
        }
        
        if textField == cityTextField {
            view.endEditing(true)
            presenter.openCitySelection()
            return false
        }
        
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == categoryTextField || textField == cityTextField {
            return false
        } else {
            return true
        }
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
    
    func setupTextFields() {
        let textFields = [nameTextField, descriptionTextField, sizeTextField, priceTextField, contactInfoTextField]
        for textField in textFields {
            textField?.delegate = self
            textField?.addDoneToolbar()
        }
        
        categoryTextField.delegate = self
        categoryTextField.clearButtonMode = .never
        
        cityTextField.delegate = self
        cityTextField.clearButtonMode = .never
    }
    
    func nextTextField(for textField: UITextField) -> UITextField? {
        let nextTag = textField.tag + 1
        return view.viewWithTag(nextTag) as? UITextField
    }
}
