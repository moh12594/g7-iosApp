//
//  RoundedButton.swift
//  astro
//
//  Created by Mohamed SADAT on 19/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

  @IBInspectable var cornerRadius:  CGFloat = 3.0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }

  @IBInspectable var rightSpace:  CGFloat = 40.0 {
    didSet {
      self.titleEdgeInsets.right = rightSpace
    }
  }
  
  override func awakeFromNib() {
    self.setupView()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    self.setupView()
  }
  
  func setupView() {
    self.titleEdgeInsets.right = rightSpace
    self.layer.cornerRadius = cornerRadius
  }
}
