//
//  podcastCell.swift
//  astro
//
//  Created by Mohamed SADAT on 21/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit
import AVFoundation

class podcastCell: UICollectionViewCell {
  var player: AVAudioPlayer?
  var audioFile: String = "music1"
  
  @IBOutlet weak var podcastImage: UIImageView!
  @IBOutlet weak var podcastTitle: UILabel!
  
  @IBAction func playButtonWasClicked(_ sender: Any) {
    if player != nil {
      if (player?.isPlaying)! {
        player?.pause()
        return
      }
    }
    guard let url = Bundle.main.url(forResource: audioFile, withExtension: "mp3") else { return }
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
      try AVAudioSession.sharedInstance().setActive(true)
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      guard let player = player else { return }
      if player.isPlaying {
        player.pause()
      } else {
        player.play()
      }
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
}
