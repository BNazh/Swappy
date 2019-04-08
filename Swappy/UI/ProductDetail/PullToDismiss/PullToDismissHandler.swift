//
//  PullToDismissHandler.swift
//  Swappy
//
//  Created by Mihail on 08/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class PullToDismissHandler: NSObject {
    
    var panGestureRecognizer : UIPanGestureRecognizer!
    var scrollView: UIScrollView!
    var dismissCallback: (() -> Void)?
    
    var allowDismiss: Bool = false
    
    let maxOffset: CGFloat = 200
    
    func setup(scrollView: UIScrollView, dismissCallback: @escaping () -> Void) {
        self.dismissCallback = dismissCallback
        self.scrollView = scrollView
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panRecognized))
        panGestureRecognizer.delegate = self
        scrollView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func panRecognized(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            allowDismiss = scrollView.contentOffset.y == 0
        } else if recognizer.state != .ended && recognizer.state != .cancelled && recognizer.state != .failed && scrollView.contentOffset.y == 0 {
            
            let panOffset = recognizer.translation(in: scrollView)
            let isEligiblePanOffset = panOffset.y > maxOffset
            
            if isEligiblePanOffset && allowDismiss {
                recognizer.isEnabled = false
                recognizer.isEnabled = true
                dismissCallback?()
            }
        }
    }
}

extension PullToDismissHandler: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
