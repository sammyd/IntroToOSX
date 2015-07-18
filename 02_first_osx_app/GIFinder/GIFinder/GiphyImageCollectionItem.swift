/*
 * Copyright (c) 2015 Razeware LLC
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Cocoa

class GiphyImageCollectionItem: NSCollectionViewItem {
  
  @IBOutlet weak var gifImageView: NSImageView!
  @IBOutlet weak var loadingIndicator: NSProgressIndicator!
  
  @IBAction func handleImageClicked(sender: AnyObject) {
    gifImageView.animates = !gifImageView.animates
  }
  
  private var imageDownloadTask : NSURLSessionDataTask?
  private static let imageCache = NSCache()
  
  var giphyItem : GiphyItem? {
    didSet {
      gifImageView.animates = false
      gifImageView.image = nil
      loadingIndicator.hidden = false
      loadingIndicator.startAnimation(self)
      if let giphyItem = giphyItem {
        // Check the cache
        if let image = GiphyImageCollectionItem.imageCache.objectForKey(giphyItem.id) as? NSImage {
          self.gifImageView.image = image
          self.loadingIndicator.stopAnimation(self)
          self.loadingIndicator.hidden = true
        } else {
          loadImageAysnc(giphyItem.url) {
            image in
            self.gifImageView.image = image
            self.loadingIndicator.stopAnimation(self)
            self.loadingIndicator.hidden = true
            GiphyImageCollectionItem.imageCache.setObject(image, forKey: giphyItem.id)
          }
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
