//
//  RoundedButton.swift
//  SwiftCalculator
//
//  Created by suraj poudel on 4/2/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class RoundedButton:UIButton{
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = self.bounds.height * 0.5
        clipsToBounds = true
    }
}
