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

class HomeVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func facebookLoginWasPressed(_ sender: Any) {
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
      AnalyticsParameterItemID: "Facebook clocked" as NSObject,
      AnalyticsParameterItemName: "ok ok" as NSObject,
      AnalyticsParameterContentType: "cont" as NSObject
      ])
    AuthService.instance.facebookLogin(viewConroller: self) { (success) in
      if success {
        self.performSegue(withIdentifier: "connected", sender: nil)
      } else {
        print("error")
      }
    }
  }

  
}

