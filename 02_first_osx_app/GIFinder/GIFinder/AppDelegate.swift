//
//  AppDelegate.swift
//  GIFinder
//
//  Created by Sam Davies on 17/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



  func applicationDidFinishLaunching(aNotification: NSNotification) {
    // Insert code here to initialize your application
    
    searchGiphy("dog collar") {
      result in
      switch result {
      case .Error(let error):
        print(error.localizedDescription)
      case .Result(let giphyItems):
        print(giphyItems)
      }
    }
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }


}

