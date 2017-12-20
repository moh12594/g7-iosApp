//
//  AstroService.swift
//  astro
//
//  Created by Mohamed SADAT on 20/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import Alamofire
import SwiftyJSON

import Foundation

class AstroService {
  
  static let instance = AstroService()
  
  func testApi(completion: @escaping CompletionHandler) {
    let dic = ["date": 25 as Int,
               "month": 12 as Int,
               "year": 1988 as Int,
               "hour": 4 as Int,
               "minute": 0 as Int,
               "latitude": 25.123 as Float,
               "longitude": 82.34 as Float,
               "timezone": 5.5 as Float
      ] as [String : Any]
    
    Alamofire.request("\(ASTRO_API)astro_details", method: .post, parameters: dic, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
      if response.result.error == nil {
        print("Heloooooo 22")
        guard let data = response.data else {return}
        let json = try? JSON(data: data)
        guard let jsonnn = json else {return}
        print("Heloooooo \(jsonnn)")
        

//        if let json = JSON(data: data).array {
//          print(json)
//          completion(true)
//        }
      } else {
        debugPrint(response.result.error as Any)
        completion(false)
      }
    }
  }
}
