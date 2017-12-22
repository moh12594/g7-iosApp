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
  var horoscopes = [String]()
  
  func getAllHoroscopes(completion: @escaping CompletionHandler) {
    self.getToDayHoroscope { (toDayHoroscope) in
      self.horoscopes.append(toDayHoroscope)
      self.getWeekHoroscope(handler: { (weekHoroscope) in
        self.horoscopes.append(weekHoroscope)
        self.getMonthHoroscope(handler: { (monthHoroscope) in
          self.horoscopes.append(monthHoroscope)
          completion(true)
        })
      })
    }
  }
  
  func getMonthHoroscope(handler: @escaping (_ horoscope: String) -> ()) {
    DataService.instance.getUserSunSign { (userSign) in
      Alamofire.request("\(HOROSCOPE_API)month/\(userSign)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
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
  
  func getWeekHoroscope(handler: @escaping (_ horoscope: String) -> ()) {
    DataService.instance.getUserSunSign { (userSign) in
      Alamofire.request("\(HOROSCOPE_API)week/\(userSign)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
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
  
  func getToDayHoroscope(handler: @escaping (_ horoscope: String) -> ()) {
    DataService.instance.getUserSunSign { (userSign) in
      Alamofire.request("\(HOROSCOPE_API)today/\(userSign)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
        if response.result.error == nil {
          print("Heloooooo 22")
          guard let data = response.data else {return}
          let json = try? JSON(data: data)
          let horoscope = json!["horoscope"].stringValue
          let horoscopeToReturn = horoscope.replacingOccurrences(of: "['", with: "", options: .literal, range: nil)
          handler(horoscopeToReturn)
          
        } else {
          debugPrint(response.result.error as Any)
        }
      }
    }

  }
}
