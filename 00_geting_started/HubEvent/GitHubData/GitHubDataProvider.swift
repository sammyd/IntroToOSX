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
    task.resume()
  }
}
