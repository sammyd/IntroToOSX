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
      collectionView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    collectionView.dataSource = self
    collectionView.minItemSize = NSSize(width: 200, height: 200)
    
    searchGiphy("clever dog") {
      result in
      switch result {
      case .Error(let error):
        print(error.localizedDescription)
      case .Result(let giphyItems):
        print(giphyItems)
        dispatch_async(dispatch_get_main_queue()) {
          self.giphyItems = giphyItems
        }
      }
    }
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
    return giphyItems?.count ?? 0
  }
  
  func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
    let item  = collectionView.makeItemWithIdentifier("GiphyCollectionItem", forIndexPath: indexPath)
    
    if let item = item as? GiphyImageCollectionItem {
      item.giphyItem = giphyItems?[indexPath.item]
    }
    
    return item
  }
}
