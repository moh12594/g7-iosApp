//
//  DataService.swift
//  astro
//
//  Created by Mohamed SADAT on 20/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
  
  static let instance = DataService()
  
  private var _REF_BASE = DB_BASE
  private var _REF_USERS = DB_BASE.child("users")
  
  var REF_BASE: DatabaseReference {
    return _REF_BASE
  }
  
  var REF_USERS: DatabaseReference {
    return _REF_USERS
  }
  
  func createDBUser(uid: String, userData: Dictionary<String, Any>) {
    REF_USERS.child(uid).updateChildValues(userData)
  }

  func getUsername(forUID uid: String, handler: @escaping (_ firstName: String) -> ()) {
    if Auth.auth().currentUser != nil {
      let uid = Auth.auth().currentUser?.uid
      REF_BASE.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
      let value = snapshot.value as? NSDictionary
      let username = value?["firstName"] as? String ?? ""
      handler(username)
      }) { (error) in
        print(error.localizedDescription)
      }
      } else {
      
      }
  }

}


