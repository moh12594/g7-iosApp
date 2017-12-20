//
//  WelcomeVC.swift
//  astro
//
//  Created by Mohamed SADAT on 20/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    AstroService.instance.testApi() { (success) in
      if success {
        
      } else {
        
      }
    }
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

}
