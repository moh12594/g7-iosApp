//
//  TextFielDate.swift
//  astro
//
//  Created by Mohamed SADAT on 20/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit

class TextFielDate: UITextField {
  
  @IBInspectable var placeholderText: String = "25/10/1996" {
    didSet {
      self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)])
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
    self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)])
  }
  
}
