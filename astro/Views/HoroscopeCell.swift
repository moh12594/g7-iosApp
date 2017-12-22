//
//  HoroscopeCell.swift
//  astro
//
//  Created by Mohamed SADAT on 22/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit

class HoroscopeCell: UICollectionViewCell {
    
  @IBOutlet weak var horoscopeLabel: UILabel!
  @IBOutlet weak var horoscopeTitle: UILabel!
  @IBOutlet weak var sunSignLabel: UILabel!
  @IBOutlet weak var sunSignImage: UIImageView!
  
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
    self.layer.cornerRadius = cornerRadius
  }
  
}
