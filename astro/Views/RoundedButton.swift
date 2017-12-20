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
  
  override func awakeFromNib() {
    self.setupView()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    self.setupView()
  }
  
  func setupView() {
    self.titleEdgeInsets.right = 40
    self.layer.cornerRadius = cornerRadius
  }
}
