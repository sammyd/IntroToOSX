//
//  GiphyUtils.swift
//  gifMe
//
//  Created by Sam Davies on 19/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Foundation



enum GiphySearchResult {
  case Result([GiphyItem])
  case Error(NSError)
}

func urlForSearchTerm(searchTerm: String) -> NSURL? {
  let escapedSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+")
  let q = NSURLQueryItem(name: "q", value: escapedSearchTerm)
  let api_key = NSURLQueryItem(name: "api_key", value: "dc6zaTOxFJmzC")
  let rating = NSURLQueryItem(name: "rating", value: "pg")
  
  let url = NSURLComponents(string: "https://api.giphy.com/v1/gifs/search")
  url?.queryItems = [q, api_key, rating]
  return url?.URL
}

func convertJSONToGiphyItems(json: JSON) -> [GiphyItem] {
  var giphyItems = [GiphyItem]()
  let dataArray = json["data"]
  for (_, subJSON) : (String, JSON) in dataArray {
    if let giphyItem = GiphyItem(json: subJSON) {
      giphyItems.append(giphyItem)
    }
  }
  return giphyItems
}

