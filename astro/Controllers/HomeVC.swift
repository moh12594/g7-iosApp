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
//    if AuthService.instance.isUserLoggenIn() == true {
//      self.performSegue(withIdentifier: "connected", sender: nil)
//    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func facebookLoginWasPressed(_ sender: Any) {
    AuthService.instance.facebookLogin(viewConroller: self) { (success) in
      if success {
        self.performSegue(withIdentifier: "connected", sender: nil)
      } else {
        print("error")
      }
    }
  }
  
  @IBAction func logoutWasPressed(_ sender: Any) {
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
  }
  
}

