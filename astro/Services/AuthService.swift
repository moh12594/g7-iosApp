//
//  AuthService.swift
//  astro
//
//  Created by Mohamed SADAT on 19/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
import Alamofire
import SwiftyJSON

class AuthService {
  static let instance = AuthService()
  
  let defaults = UserDefaults.standard
  
  func isUserLoggenIn()->Bool {
    if Auth.auth().currentUser != nil {
      return true
    } else {
      return false
    }
  }
  
  func signInUser(credential: AuthCredential, completion: @escaping CompletionHandler) {
    Auth.auth().signIn(with: credential, completion: { (user, error) in
      if error == nil {
        completion(true)
      } else {
        debugPrint("Login error: \(String(describing: error?.localizedDescription))")
        completion(false)
      }
    })
  }
  
  func facebookLogin(viewConroller: UIViewController! ,completion: @escaping CompletionHandler) {
    let fbLoginManager = FBSDKLoginManager()
    fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: viewConroller) { (result, error) in
      if error == nil {
        guard let accessToken = FBSDKAccessToken.current() else {
          completion(false)
          debugPrint("Failed to get access token")
          return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
        self.signInUser(credential: credential) {(success) in
          if success {
            completion(true)
          } else {
            completion(false)
          }
        }
      } else {
        completion(false)
        debugPrint("Failed to login: \(String(describing: error?.localizedDescription))")
      }
    }
  }
}
