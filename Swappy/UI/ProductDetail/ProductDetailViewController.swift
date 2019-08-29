//
//  ProductDetailViewController.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProductDetailView: class, ErrorView, LoadingView, OkAlertView {
    func showProduct(viewModel: ProductViewModel)
    func displayActionSettings(isSellerButtonHidden: Bool, isEditViewHidden: Bool)
}

class ProductDetailViewController: UIViewController {
    
    var presenter: ProductDetailPresenter!

    @IBOutlet weak var imageSlider: ImageSlider!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var sellerContainerView: UIView!
    @IBOutlet weak var editContainerView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.showProduct()
        presenter.setActions()
        
        setupNavigationBar()
        setupScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    
    @IBAction func openSellerTouchedDown(_ sender: UIButton) {
        presenter.showSeller()
    }
    
    @IBAction func updateProductTapped(_ sender: UIButton) {
        presenter.showUpdateProduct()
    }
    
    @IBAction func deleteProductTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Подтверждение", message: "Вы действительно хотите удалить ваше объявление?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            self?.presenter.deleteProduct()
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - ProductDetailView

extension ProductDetailViewController: ProductDetailView {
    
    func showProduct(viewModel: ProductViewModel) {
        imageSlider.setImageUrls(viewModel.imageUrls)
        
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        
        sizeLabel.text = viewModel.size
        categoryLabel.text = viewModel.category
        
        descriptionLabel.text = viewModel.description
    }
    
    func displayActionSettings(isSellerButtonHidden: Bool, isEditViewHidden: Bool) {
        editContainerView.isHidden = isEditViewHidden
        sellerContainerView.isHidden = isSellerButtonHidden
    }
}

// MARK: - AnalyticScreenProvider

extension ProductDetailViewController: AnalyticScreenProvider {
    
    var screen: AnalyticScreen {
        return .productDetails
    }
}

// MARK: - Private

private extension ProductDetailViewController {
    
    func setupNavigationBar() {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
//        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .done, target: self, action: #selector(close))
//        let color = UIColor(r: 200, g: 200, b: 200, alpha: 0.2)
//        let image = UIImage.from(color: color)
//        backButton.setBackgroundImage(image, for: .normal, barMetrics: .default)
//
//        navigationController?.navigationItem.backBarButtonItem = backButton
    }
    
    @objc
    func close() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupScrollView() {
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 150, right: 0)
    }
}

private extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
