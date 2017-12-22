//
//  constants.swift
//  astro
//
//  Created by Mohamed SADAT on 19/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import Foundation
import Firebase

typealias CompletionHandler = (_ Success: Bool) -> ()

let ASTRO_API = "https://api.vedicrishiastro.com/v1/"
let HOROSCOPE_API = "https://horoscope-api.herokuapp.com/horoscope/"
let USER_API = "601540"
let SECRET_API = "5d8268426bbaa73834adb1cae55aa869"
let API_TOKEN = "\(USER_API):\(SECRET_API)".toBase64()

// User Defaults
let USER_UID = "uid"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
let USER_DETAILS = "userDetails"
let USER_SUN = "userSun"

// Headers
let HEADER = [
  "Content-Type": "application/json; charset=utf-8"
]
let BEARER_HEADER = [
  "Authorization": "Basic \(API_TOKEN)",
  "Content-Type": "application/json",
  "Accept": "application/json"
]
