//
//  DateTimeTransformer.swift
//  HubEvent
//
//  Created by Sam Davies on 06/05/2015.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Cocoa

class DateTimeTransformer: NSValueTransformer {

  let name = "DateTimeTransformer"
  
  private class var dateFormatter : NSDateFormatter {
    struct Static {
      static var instance : NSDateFormatter =  {
        let df = NSDateFormatter()
        df.dateStyle = .ShortStyle
        df.timeStyle = .ShortStyle
        return df
        }()
    }
    return Static.instance
  }
  
  override class func transformedValueClass() -> AnyClass {
    return NSString.self
  }
  
  override class func allowsReverseTransformation() -> Bool {
    return false
  }
  
  override func transformedValue(value: AnyObject?) -> AnyObject? {
    if let date = value as? NSDate {
      return self.dynamicType.dateFormatter.stringFromDate(date)
    }
    return nil
  }
}
