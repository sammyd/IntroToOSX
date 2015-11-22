//
//  ViewController.swift
//  MagicEight
//
//  Created by Sam Davies on 21/11/2015.
//  Copyright © 2015 Ray Wenderlich. All rights reserved.
//

import Cocoa

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
  
  @IBOutlet weak var nameTextField: NSTextField!
  @IBOutlet weak var welcomeLabel: NSTextField!
  @IBOutlet weak var ballImageView: NSImageView!
  @IBOutlet weak var adviceLabel: NSTextField!
  
  
  @IBAction func handleWelcome(sender: AnyObject) {
    welcomeLabel.stringValue = "Hello \(nameTextField.stringValue)!"
  }
  
  @IBAction func handleBallClick(sender: AnyObject) {
    // 1:
    if(adviceLabel.hidden) {
      // 2:
      if let advice = adviceList.randomElement {
        adviceLabel.stringValue = advice
        adviceLabel.hidden = false
        ballImageView.image = NSImage(named: "magic8ball")
      }
    } else {
      // 3:
      adviceLabel.hidden = true
      ballImageView.image = NSImage(named: "8ball")
    }
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    adviceLabel.hidden = true
    ballImageView.image = NSImage(named: "8ball")
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}


extension Array {
  var randomElement: Element? {
    if count < 1 { return .None }
    let randomIndex = arc4random_uniform(UInt32(count))
    return self[Int(randomIndex)]
  }
}

