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
import GravitySliderFlowLayout
import NVActivityIndicatorView

class WelcomeVC: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {
  
  public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
  }
  
  @IBOutlet weak var podcastCollectionView: UICollectionView!
  @IBOutlet weak var testCollection: UICollectionView!
  @IBOutlet weak var pageControlBody: UIPageControl!
  @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
  
  
  var arrayTable = ["mercure", "earth", "venus"]
  var titles = ["Today's horoscope", "Weekly horoscope", "Monthly horoscope"]
  var podcastArray = [UIImage(named: "podcast0"), UIImage(named: "podcast1"), UIImage(named: "podcast2"), UIImage(named: "podcast1")]
  var podcastTitlesArray = ["Wayne Nelson", "Carolyn Agui", "Andrea Martinez", "Wayne Nelsonz"]
  var horoscopes = [String]()
  var userSign: String = "PISCES"
  
  @IBOutlet weak var planetName: UILabel!
  @IBOutlet weak var headerImage: UIImageView!
  @IBOutlet weak var pagerView: FSPagerView! {
    didSet {
      self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
    }
  }

  @IBOutlet weak var pageControl: FSPageControl!
  
  let collectionViewCellHeightCoefficient: CGFloat = 1
  let collectionViewCellWidthCoefficient: CGFloat = 0.75
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activityIndicatorView.startAnimating()
    podcastCollectionView.dataSource = self
    podcastCollectionView.delegate = self
    
    configureCollectionView()

    
    pagerView.itemSize = CGSize(width: screenWidth, height: 300)
    pagerView.transformer = FSPagerViewTransformer(type: .zoomOut)
    pagerView.isInfinite = true
        
    pagerView.dataSource = self
    pagerView.delegate = self


    pageControl.contentHorizontalAlignment = .center
    pageControl.setFillColor(.gray, for: .normal)
    pageControl.setFillColor(.white, for: .selected)
    pageControl.numberOfPages = 3

    pagerView.isInfinite = true
    AstroService.instance.getAllHoroscopes { (success) in
      DataService.instance.getUserSunSign(handler: { (userSign) in
        self.userSign = userSign
        self.horoscopes = AstroService.instance.horoscopes
        self.activityIndicatorView.stopAnimating()
        self.testCollection.reloadData()
      })

    }

  }
  
  private func configureCollectionView() {
    let gravitySliderLayout = GravitySliderFlowLayout(with: CGSize(width: testCollection.frame.size.height * collectionViewCellWidthCoefficient, height: testCollection.frame.size.height * collectionViewCellHeightCoefficient))
    testCollection.collectionViewLayout = gravitySliderLayout
    testCollection.dataSource = self
    testCollection.delegate = self
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  public func numberOfItems(in pagerView: FSPagerView) -> Int {
    if pagerView == self.pagerView {
      return self.arrayTable.count
    } else {
      return self.horoscopes.count
    }
  }

  public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
    if pagerView == self.pagerView {
      let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
      cell.textLabel?.isHidden = true
      self.planetName.text = arrayTable[index]
      self.pageControl.currentPage = index
      cell.imageView?.isHidden = true
      self.headerImage = UIImageView(image: UIImage(named: "slider\(index)"))
      return cell
    } else {
      let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
      cell.textLabel?.isHidden = true
      cell.imageView?.isHidden = true
      return cell
    }
  }
  

  
  @IBAction func logoutButtonWasPressed(_ sender: Any) {
    AuthService.instance.logoutUser { (success) in
      if success {
        guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") else {return}
        self.present(homeVC, animated: true, completion: nil)
      }
    }
  }
  
  
}

extension WelcomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == podcastCollectionView {
      return self.podcastArray.count
    } else {
      return self.horoscopes.count
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     if collectionView == podcastCollectionView {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCell", for: indexPath) as! podcastCell
      cell.podcastImage.image = self.podcastArray[indexPath.row]
      cell.podcastTitle.text = self.podcastTitlesArray[indexPath.row]
      cell.audioFile = "music\(indexPath.row)"
      return cell
     } else {
      let horosCell = collectionView.dequeueReusableCell(withReuseIdentifier: "horoscopeCell", for: indexPath) as! HoroscopeCell
      horosCell.clipsToBounds = false
      horosCell.horoscopeTitle.text = self.titles[indexPath.row]
      horosCell.sunSignLabel.text = self.userSign.uppercased()
      horosCell.sunSignImage.image = UIImage(named: "Group")
      horosCell.horoscopeLabel.text = self.horoscopes[indexPath.row]
      return horosCell
    }
  }
}
