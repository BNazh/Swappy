//
//  TipView.swift
//  Swappy
//
//  Created by Mihail on 25/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol TipView: class {
    
    func showTip(text: String, image: UIImage)
}

extension TipView {
    
    func showTip(text: String) {
        let checkmarkImage = #imageLiteral(resourceName: "Checkmark")
        showTip(text: text, image: checkmarkImage.withRenderingMode(.alwaysTemplate))
    }
}

extension TipView where Self: UIViewController {
    
    func showTip(text: String, image: UIImage) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        hud.isSquare = true
        hud.label.text = text
        hud.mode = .customView
        hud.customView = UIImageView(image: image)
    
        hud.hide(animated: true, afterDelay: 1)
    }
}

//- (void)customViewExample {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//
//    // Set the custom view mode to show any view.
//    hud.mode = MBProgressHUDModeCustomView;
//    // Set an image view with a checkmark.
//    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    hud.customView = [[UIImageView alloc] initWithImage:image];
//    // Looks a bit nicer if we make it square.
//    hud.square = YES;
//    // Optional label text.
//    hud.label.text = NSLocalizedString(@"Done", @"HUD done title");
//
//    [hud hideAnimated:YES afterDelay:3.f];
//}
