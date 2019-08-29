//
//  UIView+ReusableIdentifiers.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Properties
    
    @nonobjc static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    @nonobjc static var nibName: String {
        return String(describing: self)
    }
    
    var firstViewController: UIViewController? {
        let nextResponder = self.next
        return (nextResponder as? UIViewController) ?? (nextResponder as? UIView)?.firstViewController
    }
    
    static func fromNib<T: UIView>() -> T? {
        return UINib(nibName: T.nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
    }
}
