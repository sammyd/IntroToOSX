//
//  ViewController.swift
//  GIFinder
//
//  Created by Sam Davies on 17/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  
  @IBOutlet weak var collectionView: NSCollectionView!
  
  
  private var giphyItems : [GiphyItem]? {
    didSet {
      if let giphyItems = giphyItems {
        collectionView.reloadData()
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}


extension ViewController : NSCollectionViewDataSource {
  func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    <#code#>
  }
}
