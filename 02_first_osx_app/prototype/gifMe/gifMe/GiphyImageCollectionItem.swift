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
      if let giphyItem = giphyItem {
        updateImageForGiphyItem(giphyItem)
      }
    }
  }
  
  private func updateImageForGiphyItem(item: GiphyItem) {
    imageDownloadTask?.cancel()
    updateUIWhilstLoading(true)
    // Check the cache
    if let image = GiphyImageCollectionItem.imageCache.objectForKey(item.id) as? NSImage {
      self.gifImageView.image = image
      updateUIWhilstLoading(false)
    } else {
      loadImageAysnc(item.url) {
        image in
        self.gifImageView.image = image
        GiphyImageCollectionItem.imageCache.setObject(image, forKey: item.id)
        self.updateUIWhilstLoading(false)
      }
    }
  }
  
  private func updateUIWhilstLoading(loading: Bool) {
    loadingIndicator.hidden = !loading
    loading ? loadingIndicator.stopAnimation(self) : loadingIndicator.startAnimation(self)
    if loading {
      gifImageView.image = nil
      gifImageView.animates = false
    }
  }
  
  private func loadImageAysnc(url: NSURL, callback: (NSImage) -> ()) {
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
