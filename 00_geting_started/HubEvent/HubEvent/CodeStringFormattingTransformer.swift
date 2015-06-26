//
//  CodeStringFormattingTransformer.swift
//  HubEvent
//
//  Created by Sam Davies on 06/05/2015.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Cocoa

class CodeStringFormattingTransformer: NSValueTransformer {
  
  let name = "CodeStringFormattingTransformer"
  
  override class func transformedValueClass() -> AnyClass {
    return NSAttributedString.self
  }
  
  override class func allowsReverseTransformation() -> Bool {
    return false
  }
  
  override func transformedValue(value: AnyObject?) -> AnyObject? {
    if let s = value as? String {
      let unescaped = s.stringByReplacingOccurrencesOfString("\\/", withString: "/")
        .stringByReplacingOccurrencesOfString("\\r", withString: "")
        .stringByReplacingOccurrencesOfString("\\n", withString: "\n")
      
      let font = NSFont(name: "Menlo", size: 11.0)!
      let attributes = [ NSFontAttributeName : font ]
      return NSAttributedString(string: unescaped, attributes: attributes)
    }
    return nil
  }
}
