//
//  AppDelegate.swift
//  HubEvent
//
//  Created by Sam Davies on 06/05/2015.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  override class func initialize() {
    super.initialize()
    let codeStringTransformer = CodeStringFormattingTransformer()
    NSValueTransformer.setValueTransformer(codeStringTransformer, forName: codeStringTransformer.name)
    let dateTimeTransformer = DateTimeTransformer()
    NSValueTransformer.setValueTransformer(dateTimeTransformer, forName: dateTimeTransformer.name)
  }
}

