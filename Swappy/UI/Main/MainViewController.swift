//
//  MainViewController.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import XLPagerTabStrip

class MainViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        setupBarSettings()
        
        super.viewDidLoad()
        
        title = "Swappy"
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let catalogVC: ProductCatalogViewController = UIStoryboard.createViewController()
        let myProductsVC: MyProductsViewController = UIStoryboard.createViewController()
        
        return [
            catalogVC,
            myProductsVC
        ]
    }
}

private extension MainViewController {
    
    func setupBarSettings() {
        settings.style.buttonBarItemsShouldFillAvailiableWidth = false
        settings.style.selectedBarHeight = 3
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = .appFont(ofSize: 17, style: .semibold)
        settings.style.selectedBarBackgroundColor = .black
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .trolleyGrey
            newCell?.label.textColor = .black
        }
    }
}


extension ProductCatalogViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "Все товары"
    }
}

extension MyProductsViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "Мои товары"
    }
}
