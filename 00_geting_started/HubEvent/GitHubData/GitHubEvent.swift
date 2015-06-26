//
//  GitHubEvent.swift
//  HubEvent
//
//  Created by Sam Davies on 06/05/2015.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Foundation


/**
Describes what constitutes an event on GitHub
*/

public class GitHubEvent: NSObject, Printable, Equatable {
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
    let id = jsonEvent["id"].string!.toInt()!
    
    var repoName = jsonEvent["repo"]["name"].string
    
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
    default:
      return ""
    }
  }
}
