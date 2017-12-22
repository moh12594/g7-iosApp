//
//  ViewController.swift
//  astro
//
//  Created by Mohamed SADAT on 18/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import NVActivityIndicatorView

class HomeVC: UIViewController {

  @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func facebookLoginWasPressed(_ sender: Any) {
    
    self.activityIndicatorView.isHidden = false
    self.activityIndicatorView.startAnimating()
    AuthService.instance.facebookLogin(viewConroller: self) { (success) in
      if success {
        Analytics.logEvent("sign_up", parameters: [
          "signUpMethod": "Facebook" ])
        DataService.instance.checkUserBirthPlace(handler: { (hasBirthPlace) in
          if hasBirthPlace {
            self.activityIndicatorView.stopAnimating()
            guard let welcomeVC = storyboard?.instantiateViewController(withIdentifier: "welcomeVC") else {return}
            present(welcomeVC, animated: true, completion: nil)
          } else {
            self.activityIndicatorView.stopAnimating()
            self.performSegue(withIdentifier: "connected", sender: nil)
          }
        })
        
      } else {
        print("error")
      }
    }
  }

  
}

