//
//  shared.swift
//  astro
//
//  Created by Mohamed SADAT on 21/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import Foundation

func calculateSunSign(birthDate: String)->String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "dd/MM/YYYY"
  
  /**
   Aries Horoscope Dates (March 21-April 19)
   
   Taurus Horoscope Dates (April 20-May 20)
   
   Gemini Horoscope Dates May 21-June 20)
   
   Cancer Horoscope Dates June 21-July 22)
   
   Leo Horoscope Dates (July 23-August 22)
   
   Virgo Horoscope Dates (August 23-September 22)
   
   Libra Horoscope Dates (September 23-October 22)
   
   Scorpio Horoscope Dates (October 23-November 21)
   
   Sagittarius Horoscope Dates (November 22-December 21)
   
   Capricorn Horoscope Dates (December 22-January 19)
   
   Aquarius Horoscope Dates (January 20 to February 18)
   
   Pisces Horoscope Dates (February 19 to March 20)
   **/
  
  if let date = dateFormatter.date(from: birthDate) {
    print("YEES \(date)")
    dateFormatter.dateFormat = "yyyy"
    let yearString: String = dateFormatter.string(from: date)
    let year = Int(yearString)
    dateFormatter.dateFormat = "MM"
    let monthString: String = dateFormatter.string(from: date)
    let month = Int(monthString)
    print("YEES \(month)")
    dateFormatter.dateFormat = "dd"
    let dayString: String = dateFormatter.string(from: date)
    let day = Int(dayString)
    print("YEES \(day)")
    let ariesDate: Bool = (month! == 03 && day! >= 21) || (month! == 04 && day! < 20)
    let taurusDate: Bool = (month! == 04 && day! >= 21) || (month! == 05 && day! < 21)
    let geminiDate: Bool = (month! == 05 && day! >= 21) || (month! == 06 && day! < 21)
    let cancerDate: Bool = (month! == 06 && day! >= 21) || (month! == 07 && day! < 23)
    let leoDate: Bool = (month! == 07 && day! >= 23) || (month! == 08 && day! < 23)
    let virgoDate: Bool = (month! == 08 && day! >= 23) || (month! == 09 && day! < 23)
    let libraDate: Bool = (month! == 09 && day! >= 23) || (month! == 10 && day! < 23)
    let scorpioDate: Bool = (month! == 10 && day! >= 23) || (month! == 11 && day! < 22)
    let sagittarius: Bool = (month! == 11 && day! >= 22) || (month! == 12 && day! < 22)
    let capricornDate: Bool = (month! == 12 && day! >= 22) || (month! == 01 && day! < 20)
    let aquariusDate: Bool = (month! == 01 && day! >= 20) || (month! == 02 && day! < 29)
    let piscesDate: Bool = (month! == 02 && day! >= 19) || (month! == 03 && day! < 21)
    
    if (ariesDate) {
      return "aries"
    }
    if (taurusDate) {
      return "taurus"
    }
    if (geminiDate) {
      return "gemini"
    }
    if (cancerDate) {
      return "cancer"
    }
    if (leoDate) {
      return "leo"
    }
    if (virgoDate) {
      return "virgo"
    }
    if (libraDate) {
      return "libra"
    }
    if (scorpioDate) {
      return "scorpio"
    }
    if (sagittarius) {
      return "sagittarius"
    }
    if (capricornDate) {
      return "capricorn"
    }
    if (aquariusDate) {
      return "aquarius"
    }
    if (piscesDate) {
      return "pisces"
    }
  }
  return "libra"
}
