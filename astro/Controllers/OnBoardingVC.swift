//
//  onBoardingVC.swift
//  astro
//
//  Created by Mohamed SADAT on 19/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class OnBoardingVC: UIViewController, UIGestureRecognizerDelegate {

  @IBOutlet weak var backgroundView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let currentUser = Auth.auth().currentUser {
      print(currentUser.displayName)
    }
    onScreenTap()
    
  }
  
  func onScreenTap() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(goToBirthdateVC))
    tap.numberOfTapsRequired = 1
    tap.delegate = self
    backgroundView.addGestureRecognizer(tap)
  }
  
  @objc func goToBirthdateVC() {
    guard let bdVC = storyboard?.instantiateViewController(withIdentifier: "birthDateVC") else {return}
    present(bdVC, animated: true, completion: nil)
  }
}
