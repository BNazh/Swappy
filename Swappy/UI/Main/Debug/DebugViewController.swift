//
//  DebugViewController.swift
//  Swappy
//
//  Created by Mihail on 29/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class DebugViewController: UIViewController, TipView {
    
    let keychain = KeychainStoreImp()
    let pasteboard = UIPasteboard.general
    
    @IBAction func logout(_ sender: Any) {
        
        keychain.clear()
        showTip(text: "Выход")
    }
    
    @IBAction func copySellerId(_ sender: Any) {
        
        pasteboard.string = keychain.userSellerId
        showTip(text: "Скопировано")
    }
    
    @IBAction func copyAccessToken(_ sender: Any) {
        pasteboard.string = keychain.accessToken
        showTip(text: "Скопировано")
    }
}
