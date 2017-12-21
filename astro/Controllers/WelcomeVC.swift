//
//  WelcomeVC.swift
//  astro
//
//  Created by Mohamed SADAT on 20/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit
import Firebase
import FSPagerView

class WelcomeVC: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {
  
  public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
  }
  
  @IBOutlet weak var podcastCollectionView: UICollectionView!
  
  var arrayTable = ["mercure", "earth", "venus"]
  var podcastArray = [UIImage(named: "podcast0"), UIImage(named: "podcast1"), UIImage(named: "podcast2"), UIImage(named: "podcast1")]
    var podcastTitlesArray = ["Wayne Nelson", "Carolyn Agui", "Andrea Martinez", "Wayne Nelsonz"]
  @IBOutlet weak var planetName: UILabel!
  
  @IBOutlet weak var headerImage: UIImageView!
  @IBOutlet weak var pagerView: FSPagerView! {
    didSet {
      self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
    }
  }
  
  @IBOutlet weak var bodySlider: FSPagerView! {
    didSet {
      self.bodySlider.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
    }
  }
  @IBOutlet weak var pageControl: FSPageControl!
  
  @IBOutlet weak var userSignLabel: UILabel!
  @IBOutlet weak var toDayHoroscopeLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
    podcastCollectionView.dataSource = self
    podcastCollectionView.delegate = self
 

    
    pagerView.itemSize = CGSize(width: screenWidth, height: 300)
    pagerView.transformer = FSPagerViewTransformer(type: .zoomOut)
    pagerView.isInfinite = true
    
    bodySlider.interitemSpacing = 15
    
    pagerView.dataSource = self
    pagerView.delegate = self
    bodySlider.dataSource = self
    bodySlider.delegate = self

    pageControl.contentHorizontalAlignment = .center
    pageControl.setFillColor(.gray, for: .normal)
    pageControl.setFillColor(.white, for: .selected)
    pageControl.numberOfPages = 3
    AstroService.instance.testApi() { (horoscope) in
      self.toDayHoroscopeLabel.text = horoscope
      self.bodySlider.reloadData()
    }

  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  public func numberOfItems(in pagerView: FSPagerView) -> Int {
    if pagerView == self.pagerView {
      return self.arrayTable.count
    } else {
      return 2
    }
  }

  public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
    if pagerView == self.pagerView {
      let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
      cell.textLabel?.isHidden = true
      self.planetName.text = arrayTable[index]
      self.pageControl.currentPage = index
      //    cell.imageView?.image = UIImage(named: "slider\(index)")
      cell.imageView?.isHidden = true
      self.headerImage = UIImageView(image: UIImage(named: "slider\(index)"))
//      cell.backgroundView = UIImageView(image: UIImage(named: "slider\(index)"))
      return cell
    } else {
      let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
      cell.textLabel?.isHidden = true
//      self.toDayHoroscopeLabel.text = arrayTable[index]
//      self.pageControl.currentPage = index
      //    cell.imageView?.image = UIImage(named: "slider\(index)")
      cell.imageView?.isHidden = true
//      cell.backgroundView = UIImageView(image: UIImage(named: "slider\(index)"))
      return cell
    }
  }
  
  @IBAction func logoutButtonWasPressed(_ sender: Any) {
    do {
      try Auth.auth().signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
  }
  
}

extension WelcomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.podcastArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCell", for: indexPath) as! podcastCell
    cell.podcastImage.image = self.podcastArray[indexPath.row]
    cell.podcastTitle.text = self.podcastTitlesArray[indexPath.row]
    return cell
    
    
  }
}
