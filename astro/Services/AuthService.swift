//
//  AuthService.swift
//  astro
//
//  Created by Mohamed SADAT on 19/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import Firebase
import FBSDKLoginKit
import Alamofire
import SwiftyJSON

class AuthService {
  static let instance = AuthService()
  
  let defaults = UserDefaults.standard
  
  var userUid: String {
    get {
      return defaults.value(forKey: USER_UID) as! String
    }
    set {
      defaults.set(newValue, forKey: USER_UID)
    }
  }
  
  var userEmail: String {
    get {
      return defaults.value(forKey: USER_EMAIL) as! String
    }
    set {
      defaults.set(newValue, forKey: USER_EMAIL)
    }
  }
  
  var isLoggedIn: Bool {
    get {
      return defaults.bool(forKey: LOGGED_IN_KEY)
    }
    set {
      defaults.set(newValue, forKey: LOGGED_IN_KEY)
    }
  }
  
  var userSunSign: String {
    get {
      return defaults.value(forKey: USER_SUN) as! String
    }
    set {
      defaults.set(newValue, forKey: USER_SUN)
    }
  }
  
  
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
        self.userUid = (user?.uid)!
        self.userEmail = (user?.email)!
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
            self.getFacebookProfile(uid: self.userUid, email: self.userEmail)
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
  
  func getFacebookProfile(uid: String, email: String) {
    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, last_name, first_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
      if (error == nil) {
        let fbDetails = result as! NSDictionary
        let firstName = fbDetails["first_name"]
        let lastName = fbDetails["last_name"]
        let userDic = ["firstName": firstName, "lastName": lastName, "email": email]
        DataService.instance.createDBUser(uid: self.userUid, userData: userDic)
        print(fbDetails["first_name"])
      }
    })
  }
  
  func setBirthDate(birthDate: String) {
    let sunSign = calculateSunSign(birthDate: birthDate)
    let userDic = ["birthDate": birthDate, "sunSign": sunSign]
    DataService.instance.createDBUser(uid: self.userUid, userData: userDic)
  }
  
  func setBirthTime(birthTime: String) {
    let userDic = ["birthTime": birthTime]
    DataService.instance.createDBUser(uid: self.userUid, userData: userDic)
  }
  
  func setBirthPlace(birthPlace: String) {
    let userDic = ["birthPlace": birthPlace]
    DataService.instance.createDBUser(uid: self.userUid, userData: userDic)
  }
}
