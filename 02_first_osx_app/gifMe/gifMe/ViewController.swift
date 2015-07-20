//
//  ViewController.swift
//  gifMe
//
//  Created by Sam Davies on 19/07/2015.
//  Copyright © 2015 RayWenderlich. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet weak var collectionView: NSCollectionView!
  
  var giphyItems : [GiphyItem]? {
    didSet {
      collectionView.reloadData()
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    collectionView.dataSource = self
    collectionView.minItemSize = NSSize(width: 200, height: 200)
    collectionView.registerClass(GiphyCollectionItem.self, forItemWithIdentifier: "GiphyCollectionItem")
    
    searchGiphy("excited") {
      giphyResult in
      switch giphyResult {
      case .Error(let error):
        print(error)
      case .Result(let items):
        self.giphyItems = items
      }
    }
  }
}


extension ViewController : NSCollectionViewDataSource {
  // 1:
  func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
    return 1
  }
  
  // 2:
  func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return giphyItems?.count ?? 0
  }
  
  // 3:
  func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
    // 4:
    let item  = collectionView.makeItemWithIdentifier("GiphyCollectionItem", forIndexPath: indexPath)
    
    // 5:
    if let item = item as? GiphyCollectionItem {
      item.giphyItem = giphyItems?[indexPath.item]
    }
    
    return item
  }
}
