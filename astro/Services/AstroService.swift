//
//  AstroService.swift
//  astro
//
//  Created by Mohamed SADAT on 20/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import Firebase
import Alamofire
import SwiftyJSON


class AstroService {
  
  static let instance = AstroService()
  

  func testApi(handler: @escaping (_ firstName: String) -> ()) {
    DataService.instance.getUserSunSign { (userSign) in
      Alamofire.request("\(HOROSCOPE_API)\(userSign)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
        if response.result.error == nil {
          print("Heloooooo 22")
          guard let data = response.data else {return}
          let json = try? JSON(data: data)
          let horoscope = json!["horoscope"].stringValue
          handler(horoscope)
          
        } else {
          debugPrint(response.result.error as Any)
        }
      }
    }

  }
}
