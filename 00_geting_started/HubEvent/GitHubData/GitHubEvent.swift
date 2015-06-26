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


/**
Describes what constitutes an event on GitHub
*/

public class GitHubEvent: NSObject {
  public let id: Int
  public let eventType: GitHubEventType
  public let repoName: String?
  public let time: NSDate?
  public let rawJSON: String?
  private class var dateFormatter : NSDateFormatter {
    struct Static {
      static let instance : NSDateFormatter = NSDateFormatter()
    }
    return Static.instance
  }
  
  public init(id: Int, eventType: GitHubEventType, repoName: String?, time: NSDate?, rawJSON: String?) {
    self.id = id
    self.eventType = eventType
    self.repoName = repoName
    self.time = time
    self.rawJSON = rawJSON
  }
  
  public convenience init(json: JSON) {
    let data = GitHubEvent.extractDataFromJson(json)
    self.init(id: data.id, eventType: data.eventType, repoName: data.repoName, time: data.time, rawJSON: json.rawString())
  }
  
  public class func extractDataFromJson(jsonEvent: JSON) -> (id: Int, eventType: GitHubEventType, repoName: String?, time: NSDate?) {
    let id = Int(jsonEvent["id"].string!)!
    
    let repoName = jsonEvent["repo"]["name"].string
    
    var eventType: GitHubEventType = .Other
    if let eventString = jsonEvent["type"].string {
      switch eventString {
      case "CreateEvent":
        eventType = .Create
      case "DeleteEvent":
        eventType = .Delete
      case "ForkEvent":
        eventType = .Fork
      case "PushEvent":
        eventType = .Push
      case "WatchEvent":
        eventType = .Watch
      case "FollowEvent":
        eventType = .Follow
      case "IssuesEvent":
        eventType = .Issues
      case "IssueCommentEvent":
        eventType = .IssueComment
      default:
        eventType = .Other
      }
    }
    
    var date: NSDate?
    if let createdString = jsonEvent["created_at"].string {
      GitHubEvent.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
      date = GitHubEvent.dateFormatter.dateFromString(createdString)
    }
    
    return (id, eventType, repoName, date)
  }
  
  // Printable
  public override var description: String {
    return "[\(id)] \(time) : \(eventType.rawValue)) \(repoName)"
  }
  
  // KVO niceness
  public var eventIcon: String {
    return eventType.icon
  }
}

// Equatable
public func ==(lhs: GitHubEvent, rhs: GitHubEvent) -> Bool {
  return lhs.id == rhs.id
}


/**
Event Type

GitHub events represent lots of different actions. This enum covers them.
*/
public enum GitHubEventType: String {
  case Create = "create"
  case Delete = "delete"
  case Fork = "fork"
  case Push = "push"
  case Watch = "watch"
  case Follow = "follow"
  case Issues = "issues"
  case IssueComment = "comment"
  case Other = "other"
  
  /**
  Icons come from the github-octicons font
  */
  public var icon: String {
    switch self {
    case .Create:
      return ""
    case .Delete:
      return ""
    case .Follow:
      return ""
    case .Fork:
      return ""
    case .IssueComment:
      return ""
    case .Issues:
      return ""
    case .Other:
      return ""
    case .Push:
      return ""
    case .Watch:
      return ""
    }
  }
}
