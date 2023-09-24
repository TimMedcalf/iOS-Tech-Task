//
//  ErrorAlertPresenter.swift
//  MoneyBox
//
//  Created by Tim Medcalf on 24/09/2023.
//

import UIKit

struct ErrorAlertPresenter {
    let message: String
    
    func present(in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok".localized, style: .default, handler: nil)
        
        alert.addAction(action)
        
        runOnMainThread { viewController.present(alert, animated: true) }
    }
}
