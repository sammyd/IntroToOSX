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
  @IBOutlet weak var loadingIndicator: NSProgressIndicator!
  
  @IBAction func handleImageClicked(sender: AnyObject) {
    gifImageView.animates = !gifImageView.animates
  }
  
  private var imageDownloadTask : NSURLSessionDataTask?
  
  var giphyItem : GiphyItem? {
    didSet {
      gifImageView.animates = false
      gifImageView.image = nil
      loadingIndicator.hidden = false
      loadingIndicator.startAnimation(self)
      if let giphyItem = giphyItem {
        loadImageAysnc(giphyItem.url) {
          image in
          self.gifImageView.image = image
          self.loadingIndicator.stopAnimation(self)
          self.loadingIndicator.hidden = true
        }
      }
    }
  }
  
  private func loadImageAysnc(url: NSURL, callback: (NSImage) -> ()) {
    if let imageDownloadTask = imageDownloadTask {
      imageDownloadTask.cancel()
    }
    
    imageDownloadTask = NSURLSession.sharedSession().dataTaskWithURL(url) {
      (data, _, _) in
      if let data = data {
        let image = NSImage(data: data)
        dispatch_async(dispatch_get_main_queue()) {
          callback(image!)
          self.imageDownloadTask = nil
        }
      }
    }
    imageDownloadTask?.resume()
  }
}
