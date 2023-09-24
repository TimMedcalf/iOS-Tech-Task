//
//  GlobalFunctions.swift
//  MoneyBox
//
//  Created by Tim Medcalf on 23/09/2023.
//

import UIKit

func runOnMainThread(action: @escaping () -> Void) {
    if Thread.isMainThread {
        action()
    } else {
        DispatchQueue.main.async { action() }
    }
}
