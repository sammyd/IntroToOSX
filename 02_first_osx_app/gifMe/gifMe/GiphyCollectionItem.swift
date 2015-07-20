//
//  GiphyCollectionItem.swift
//  gifMe
//
//  Created by Sam Davies on 20/07/2015.
//  Copyright © 2015 RayWenderlich. All rights reserved.
//

import Cocoa

class GiphyCollectionItem: NSCollectionViewItem {
  
  private var imageDownloadTask : NSURLSessionDataTask?
  private static let imageCache = NSCache()
  
  @IBAction func handleClick(sender: AnyObject) {
    if let imageView = imageView {
      imageView.animates = !imageView.animates
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do view setup here.
  }
  
  var giphyItem : GiphyItem? {
    didSet {
      if let giphyItem = giphyItem {
        updateImageForGiphyItem(giphyItem)
      }
    }
  }
  
  private func updateImageForGiphyItem(item: GiphyItem) {
    imageView?.animates = false
    imageView?.image = nil
    // 1:
    imageDownloadTask?.cancel()
    // 2:
    if let image = GiphyCollectionItem.imageCache.objectForKey(item.id) as? NSImage {
      self.imageView?.image = image
    } else {
      // 3:
      loadImageAysnc(item.url) {
        image in
        // 4:
        self.imageView?.image = image
        GiphyCollectionItem.imageCache.setObject(image, forKey: item.id)
      }
    }
  }
  
  private func loadImageAysnc(url: NSURL, callback: (NSImage) -> ()) {
    // 1:
    imageDownloadTask = NSURLSession.sharedSession().dataTaskWithURL(url) {
      (data, _, _) in
      if let data = data {
        // 2:
        let image = NSImage(data: data)
        // 3:
        dispatch_async(dispatch_get_main_queue()) {
          // 4:
          callback(image!)
          // 5:
          self.imageDownloadTask = nil
        }
      }
    }
    // 6:
    imageDownloadTask?.resume()
  }
}
