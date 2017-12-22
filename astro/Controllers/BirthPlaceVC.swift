//
//  BirthPlaceVC.swift
//  astro
//
//  Created by Mohamed SADAT on 20/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit
import Firebase

class BirthPlaceVC: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var birthPlaceField: TextFielDate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    birthPlaceField.delegate = self
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    if birthPlaceField.text != "" {
      AuthService.instance.setBirthPlace(birthPlace: birthPlaceField.text!)
      Analytics.setUserProperty(birthPlaceField.text!, forName: "user_birth_city")
      guard let secondOnBoardingVC = storyboard?.instantiateViewController(withIdentifier: "secondOnBoardingVC") else {return false}
      present(secondOnBoardingVC, animated: true, completion: nil)
    }
    return true
  }

  @IBAction func birthPlaceFieldHasFinished(_ sender: Any) {
  }
}
