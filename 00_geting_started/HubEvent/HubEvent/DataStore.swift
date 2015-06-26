//
//  DataStore.swift
//  HubEvent
//
//  Created by Sam Davies on 06/05/2015.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Foundation
import GitHubData

enum DataSourceType {
  case Network
  case Disk
}


class DataStore : NSObject {
  private let dataProvider: GitHubDataProvider
  
  dynamic var events = [GitHubEvent]()
  dynamic var selectionIndexes = NSIndexSet()
  
  init(username: String, type: DataSourceType) {
    switch type {
    case .Network:
      dataProvider = GitHubDataNetworkProvider()
    case .Disk:
      dataProvider = GitHubDataFileProvider()
    }
    
    super.init()
    
    dataProvider.getEvents(username) {
      self.events = $0
    }
  }
  
  convenience init(username: String) {
    self.init(username: username, type: .Disk)
  }
}