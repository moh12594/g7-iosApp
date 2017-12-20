//
//  WelcomeVC.swift
//  astro
//
//  Created by Mohamed SADAT on 20/12/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import UIKit
import FSPagerView

class WelcomeVC: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {

  override func viewDidLoad() {
    super.viewDidLoad()
    let pagerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
    pagerView.interitemSpacing = 10
    pagerView.itemSize = CGSize(width: 150, height: 280)
    pagerView.transformer = FSPagerViewTransformer(type: .linear)
    pagerView.dataSource = self
    pagerView.delegate = self
    pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
    self.view.addSubview(pagerView)
    // Create a page control
    let pageControl = FSPageControl(frame: CGRect(x: 0, y: 0, width: 375, height: 300))
    self.view.addSubview(pageControl)
    
    AstroService.instance.testApi() { (success) in
      if success {
        
      } else {
        
      }
    }
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: "kabyle")
            cell.textLabel?.text = "OK OK OK"
        return cell
    }
}
