//
//  ErrorModel.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import Foundation

struct ErrorModel {
    let title : String
    let description : String
    let buttonTitle : String
    let action : (()->())
}
