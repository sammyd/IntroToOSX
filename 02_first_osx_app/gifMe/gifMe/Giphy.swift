//
//  Giphy.swift
//  gifMe
//
//  Created by Sam Davies on 19/07/2015.
//  Copyright © 2015 RayWenderlich. All rights reserved.
//

import Foundation

struct GiphyItem {
  let id: String
  let caption: String
  let url: NSURL
}


extension GiphyItem {
  init?(json: JSON) {
    guard let id = json["id"].string,
      let caption = json["caption"].string,
      let urlString = json["images"]["fixed_height"]["url"].string,
      let url = NSURL(string: urlString) else {
        return nil
    }
    self.init(id: id, caption: caption, url: url)
  }
}


func searchGiphy(searchTerm: String, resultHandler: (GiphySearchResult) -> ()) {
  // 1:
  guard let url = urlForSearchTerm(searchTerm) else {
    print("Error creating the search URL")
    return
  }
  // 2:
  let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
    (data, response, error) in
    if let error = error {
      print("Error: \(error.localizedDescription)")
      resultHandler(GiphySearchResult.Error(error))
      return
    }
    // 3:
    let json = JSON(data: data!)
    // 4:
    let giphyItems = convertJSONToGiphyItems(json)
    // 5:
    resultHandler(GiphySearchResult.Result(giphyItems))
    
  })
  // 6:
  task?.resume()
}

