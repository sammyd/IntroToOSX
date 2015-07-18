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
      if let giphyItemUnwrapped = giphyItem {
        if let gif = giphyItemUnwrapped.image {
          gifImageView.image = gif
        } else {
          // Need to load the image
          loadImageAysnc(giphyItemUnwrapped.url) {
            image in
            self.gifImageView.image = image
            self.giphyItem?.image = image
          }
        }
      }
    }
  }
  
  private func loadImageAysnc(url: NSURL, callback: (NSImage) -> ()) {
    NSURLSession.sharedSession().dataTaskWithURL(url) {
      (data, _, _) in
      let image = NSImage(data: data!)
      dispatch_async(dispatch_get_main_queue()) {
        callback(image!)
      }
    }?.resume()
  }
  
}
