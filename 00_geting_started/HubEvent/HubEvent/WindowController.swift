//
//  WindowController.swift
//  HubEvent
//
//  Created by Sam Davies on 06/05/2015.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
  
  // The shared data model
  let sharedDataStore = DataStore(username: "rwenderlich", type: .Disk)
  
  override func windowDidLoad() {
    super.windowDidLoad()
    self.contentViewController?.representedObject = sharedDataStore
  }  
}
