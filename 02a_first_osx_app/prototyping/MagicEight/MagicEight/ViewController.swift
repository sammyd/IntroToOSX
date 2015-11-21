//
//  ViewController.swift
//  MagicEight
//
//  Created by Sam Davies on 21/11/2015.
//  Copyright © 2015 Ray Wenderlich. All rights reserved.
//

import Cocoa

extension Array {
  var randomElement: Element? {
    if count < 1 { return .None }
    let randomIndex = arc4random_uniform(UInt32(count))
    return self[Int(randomIndex)]
  }
}


class ViewController: NSViewController {
  
  let adviceList = [
    "Yes",
    "No",
    "Ray says 'do it!'",
    "Maybe",
    "Try again later",
    "How can I know?",
    "Totally",
    "Never",
  ]
  
  
  @IBOutlet weak var helloLabel: NSTextField!
  @IBOutlet weak var nameField: NSTextField!
  @IBOutlet weak var ballImageView: NSImageView!
  @IBOutlet weak var adviceLabel: NSTextField!
  
  
  @IBAction func handleNameUpdated(sender: AnyObject) {
    var name = nameField.stringValue
    if name == "" {
      name = "World"
    }
    helloLabel.stringValue = "Hello \(name)!"
  }
  
  @IBAction func ballAction(sender: AnyObject) {
    if(adviceLabel.hidden) {
      if let advice = adviceList.randomElement {
        adviceLabel.stringValue = advice
        adviceLabel.hidden = false
        ballImageView.image = NSImage(named: "magic8ball")
      }
    } else {
      adviceLabel.hidden = true
      ballImageView.image = NSImage(named: "8ball")
    }
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    adviceLabel.hidden = true
    ballImageView.image = NSImage(named: "8ball")
    // Do any additional setup after loading the view.
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}

