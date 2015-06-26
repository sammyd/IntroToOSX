//
//  OcticonTextField.swift
//  HubEvent
//
//  Created by Sam Davies on 06/05/2015.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Cocoa

class OcticonTextField: NSTextField {
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    prepareOcticonFont()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    prepareOcticonFont()
  }
  
  private func prepareOcticonFont() {
    font = NSFont(name: "github-octicons", size: font!.pointSize)
  }
}
