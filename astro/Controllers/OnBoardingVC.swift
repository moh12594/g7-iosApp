//
//  onBoardingVC.swift
//  astro
//
//  Created by Mohamed SADAT on 19/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class OnBoardingVC: UIViewController, UIGestureRecognizerDelegate {

  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var textLabel: UILabel!
  var numberOfTaps: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let currentUser = Auth.auth().currentUser {
      print(currentUser.displayName)
    }
    onScreenTap()
    
  }
  
  func onScreenTap() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(goToBirthdateVC))
    tap.numberOfTapsRequired = 1
    tap.delegate = self
    backgroundView.addGestureRecognizer(tap)
  }
  
  func animateLabel(text: String) {
    UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
      self.textLabel.alpha = 0.0
    }, completion: {
      finished in
      
      if finished {
        //Once the label is completely invisible, set the text and fade it back in
        self.textLabel.text = text
        
        // Fade in
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
          self.textLabel.alpha = 1.0
        })
      }
    })
  }
  
  @objc func goToBirthdateVC() {
    let text = textLabel.text!
    switch text {
    case "Hello earthling.":
      numberOfTaps += 1
      animateLabel(text: "So you wanted to know more about the heavens...")
//      textLabel.text = "So you wanted to know more about the heavens..."
    case "So you wanted to know more about the heavens...":
      numberOfTaps += 1
      animateLabel(text: "You're in the right place.")
//      textLabel.text = "You're in the right place."
    case "You're in the right place.":
      numberOfTaps += 1
      animateLabel(text: "You see, Astrology is an ancient art that puts planets as an influential component in our life.")
//      textLabel.text = "You see, Astrology is an ancient art that puts planets as an influential component in our life."
    case "You see, Astrology is an ancient art that puts planets as an influential component in our life.":
      numberOfTaps += 1
      animateLabel(text: "It is, in a way, an emotional take on Astronomy.")
//      textLabel.text = "It is, in a way, an emotional take on Astronomy."
    case "It is, in a way, an emotional take on Astronomy.":
      numberOfTaps += 1
      animateLabel(text: "At the moment of your very first breath, the position of the planets determined what you are.")
//      textLabel.text = "At the moment of your very first breath, the position of the planets determined what you are."
    default:
      numberOfTaps += 1
      Analytics.logEvent("skip_onboarding", parameters: [
        "number_of_taps": numberOfTaps ])
      guard let bdVC = storyboard?.instantiateViewController(withIdentifier: "birthDateVC") else {return}
      present(bdVC, animated: true, completion: nil)
    }
  }
  
  @IBAction func skipButtonWasPressed(_ sender: Any) {
    Analytics.logEvent("skip_onboarding", parameters: [
      "number_of_taps": numberOfTaps ])
    guard let bdVC = storyboard?.instantiateViewController(withIdentifier: "birthDateVC") else {return}
    present(bdVC, animated: true, completion: nil)
  }
  
}
