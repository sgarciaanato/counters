//
//  UITextField+Utils.swift
//  Counters
//
//  Created by Samuel García on 27-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

extension UITextField {
    func activityIndicator(loading: Bool) {
        let tag = 12092
        if loading {
            let indicator = UIActivityIndicatorView()
            indicator.tag = tag
            indicator.style = .medium
            indicator.color = UIColor.black
            indicator.startAnimating()
            indicator.hidesWhenStopped = true
            self.addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            self.trailingAnchor.constraint(lessThanOrEqualTo: indicator.trailingAnchor, constant: 15).isActive = true
            indicator.centerYAnchor.constraint(lessThanOrEqualTo: self.centerYAnchor).isActive = true
        }else {
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
