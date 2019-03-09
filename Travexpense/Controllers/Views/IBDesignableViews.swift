//
//  DesignableViews.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/9/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
class CircularButton: UIButton {
  override func layoutSubviews() {
    super.layoutSubviews()
    imageView?.contentMode = .scaleAspectFill
    layer.cornerRadius = bounds.width / 2.0
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 0.5
    clipsToBounds = true
  }
}

@IBDesignable
class CircularImageView: UIImageView {
  override func layoutSubviews() {
    super.layoutSubviews()
    contentMode = .scaleAspectFill
    layer.cornerRadius = bounds.width / 2.0
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 0.5
    clipsToBounds = true
  }
}
