//
//  GiphyImageCollectionViewItem.swift
//  GIFinder
//
//  Created by Sam Davies on 17/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Cocoa

class GiphyImageCollectionItem: NSCollectionViewItem {
  
  @IBOutlet weak var gifImageView: NSImageView!
  
  var giphyItem : GiphyItem? {
    didSet {
      if let giphyItem = giphyItem {
        if let gif = giphyItem.image {
          gifImageView.image = gif
        } else {
          // Need to load the image
        }
      }
    }
  }
  
}
