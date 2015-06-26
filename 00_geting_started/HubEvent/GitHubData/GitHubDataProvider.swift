//
//  GitHubDataProvider.swift
//  HubEvent
//
//  Created by Sam Davies on 06/05/2015.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Foundation

public protocol GitHubDataProvider {
  func getEvents(user: String, callback: ([GitHubEvent])->())
}

/**
 Adds a method to JSON which can create an array of GitHubEvent objects
*/
extension JSON {
  func convertToGitHubEvents() -> [GitHubEvent] {
    let json = array
    var ghEvents = [GitHubEvent]()
    if let events = json {
      for event in events {
        let ghEvent = GitHubEvent(json: event)
        ghEvents.append(ghEvent)
      }
    }
    return ghEvents
  }
}


// Data from file

public class GitHubDataFileProvider {
  private let path: String
  
  public init(filename: String) {
    path = NSBundle(forClass: self.dynamicType)
      .pathForResource(filename, ofType: "json")!
  }
  
  public convenience init() {
    self.init(filename: "sampleData")
  }
}

extension GitHubDataFileProvider: GitHubDataProvider {
  public func getEvents(user: String, callback: ([GitHubEvent]) -> ()) {
    // Note that we're ignoring the supplied user name here
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
      let data = NSData(contentsOfFile: self.path)!
      let json = JSON(data: data, options: [], error: nil)
      let events = json.convertToGitHubEvents()
      dispatch_async(dispatch_get_main_queue()) {
        callback(events)
      }
    }
  }
}


// Data from network

public class GitHubDataNetworkProvider {
  public init() { }
}

extension GitHubDataNetworkProvider: GitHubDataProvider {
  public func getEvents(user: String, callback: ([GitHubEvent])->()) {
    let url = NSURL(string: "https://api.github.com/users/\(user)/events")
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
      (data, response, error) in
      if (error != nil) {
        print("Error: \(error!.localizedDescription)")
        return
      }
      let json = JSON(data: data!, options: [], error: nil)
      let events = json.convertToGitHubEvents()
      callback(events)
    })
    task?.resume()
  }
}
