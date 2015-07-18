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

import AppKit


struct GiphyItem {
  let id: String
  let caption: String
  let url: NSURL
  var image: NSImage?
}

extension GiphyItem {
  init?(json: JSON) {
    guard let id = json["id"].string,
      let caption = json["caption"].string,
      let urlString = json["images"]["fixed_height"]["url"].string,
      let url = NSURL(string: urlString) else {
        return nil
    }
    self.init(id: id, caption: caption, url: url, image: NSImage(named: "giphy.gif"))
  }
}

enum GiphySearchResult {
  case Result([GiphyItem])
  case Error(NSError)
}

func searchGiphy(searchTerm: String, resultHandler: (GiphySearchResult) -> ()) {
  guard let url = urlForSearchTerm(searchTerm) else {
    print("Error creating the search URL")
    return
  }
  let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
    (data, response, error) in
    if let error = error {
      print("Error: \(error.localizedDescription)")
      resultHandler(GiphySearchResult.Error(error))
      return
    }
    let json = JSON(data: data!)
    let giphyItems = convertJSONToGiphyItems(json)
    resultHandler(GiphySearchResult.Result(giphyItems))
    
  })
  task?.resume()
}


private func urlForSearchTerm(searchTerm: String) -> NSURL? {
  let escapedSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+")
  let q = NSURLQueryItem(name: "q", value: escapedSearchTerm)
  let api_key = NSURLQueryItem(name: "api_key", value: "dc6zaTOxFJmzC")
  let rating = NSURLQueryItem(name: "rating", value: "pg")
  
  let url = NSURLComponents(string: "https://api.giphy.com/v1/gifs/search")
  url?.queryItems = [q, api_key, rating]
  return url?.URL
}

private func convertJSONToGiphyItems(json: JSON) -> [GiphyItem] {
  var giphyItems = [GiphyItem]()
  let dataArray = json["data"]
  for (_, subJSON) : (String, JSON) in dataArray {
    if let giphyItem = GiphyItem(json: subJSON) {
      giphyItems.append(giphyItem)
    }
  }
  return giphyItems
}

