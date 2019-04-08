//
//  CardViewController.swift
//  Swappy
//
//  Created by Mihail on 14/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import SnapKit

// UITransitionDelegate?

class CardViewController: UIViewController {
    
    private(set) var swipeRecognizer: UISwipeGestureRecognizer!
    
    private weak var shadeView: UIView?
    private lazy var bottomView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = false
        
        addBottomView()
        addSwipeGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showShade()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeShade()
    }
}

private extension CardViewController {
    
    func showShade() {
        self.shadeView?.removeFromSuperview()
        
        let parentView = presentingViewController?.view ?? UIView()
        let shadeView = UIView(frame: parentView.frame)
        shadeView.backgroundColor = .black
        shadeView.alpha = 0
        
        parentView.addSubview(shadeView)
        
        self.shadeView = shadeView
        
        UIView.animate(withDuration: 0.5, animations: {
            shadeView.alpha = 0.4
        })
    }
    
    func removeShade() {
        UIView.animate(withDuration: 0.5, animations: {
            self.shadeView?.alpha = 0
        }) { _ in
            self.shadeView?.removeFromSuperview()
        }
    }
    
    func addBottomView() {
        view.addSubview(bottomView)
        bottomView.backgroundColor = .white
        bottomView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.height.equalTo(100)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(view.snp.bottomMargin)
        }
    }
    
    func addSwipeGestureRecognizer() {
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(downSwipeAction))
        swipeRecognizer.direction = .down
        view.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc
    func downSwipeAction() {
        dismiss(animated: true, completion: nil)
    }
}
