//
//  UITableView+Utils.swift
//  Counters
//
//  Created by Samuel García on 27-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

extension UITableView {
    func activityIndicator(loading: Bool) {
        let tag = 12093
        if loading {
            let indicator = UIActivityIndicatorView()
            indicator.tag = tag
            indicator.style = .large
            indicator.color = UIColor.black
            indicator.center = self.center
            indicator.startAnimating()
            indicator.hidesWhenStopped = true
            self.superview?.addSubview(indicator)
        }else {
            if let indicator = self.superview?.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
