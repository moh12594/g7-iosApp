//
//  SecondOnBoardingVC.swift
//  astro
//
//  Created by Mohamed SADAT on 20/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit

class SecondOnBoardingVC: UIViewController, UIGestureRecognizerDelegate {

  @IBOutlet weak var handGoodImage: UIImageView!
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet var backgroundView: UIView!
  @IBOutlet weak var kabyleSignImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    onScreenTap()
  }
  
  func onScreenTap() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(goToHome))
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
  
  func animateImage(image: UIImageView, isHidden: Bool) {
    UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
      image.isHidden = isHidden
    }, completion: nil)
  }
  
  @objc func goToHome() {
    let text = textLabel.text!
    switch text {
    case "Perfect.":
      animateImage(image: handGoodImage, isHidden: true)
      animateLabel(text: "Now you're expecting to see a zodiac sign that you might already know well.")
    //      textLabel.text = "So you wanted to know more about the heavens..."
    case "Now you're expecting to see a zodiac sign that you might already know well.":
      animateLabel(text: "But did you know this was just 1 of your signs ?")
    //      textLabel.text = "You're in the right place."
    case "But did you know this was just 1 of your signs ?":
      animateImage(image: kabyleSignImage, isHidden: false)
      animateLabel(text: "The most common is the Sun sign, and here is yours : Pisces")
    //      textLabel.text = "You see, Astrology is an ancient art that puts planets as an influential component in our life."
    case "The most common is the Sun sign, and here is yours : Pisces":
      kabyleSignImage.isHidden = true
      animateLabel(text: "But this is just the beginning, as you have actually 12 differents signs !")
    //      textLabel.text = "It is, in a way, an emotional take on Astronomy."
    case "But this is just the beginning, as you have actually 12 differents signs !":
      animateLabel(text: "Ready to know more about you ? Let's go !")
    //      textLabel.text = "At the moment of your very first breath, the position of the planets determined what you are."
    default:
      guard let welcomeVC = storyboard?.instantiateViewController(withIdentifier: "welcomeVC") else {return}
      present(welcomeVC, animated: true, completion: nil)
    }
  }

  @IBAction func skipButtonWasPressed(_ sender: Any) {
    guard let welcomeVC = storyboard?.instantiateViewController(withIdentifier: "welcomeVC") else {return}
    present(welcomeVC, animated: true, completion: nil)
  }
}
