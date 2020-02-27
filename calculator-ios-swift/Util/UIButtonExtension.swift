//
//  UIButtonExtension.swift
//  calculator-ios-swift
//
//  Created by David Martinez on 27/02/20.
//  Copyright © 2020 David Martinez. All rights reserved.
//

import UIKit

extension UIButton {
    // Borde redondo
    func round() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    // Brilla
    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }
}
