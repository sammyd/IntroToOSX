//
//  ViewController.swift
//  MagicEight
//
//  Created by Sam Davies on 21/11/2015.
//  Copyright © 2015 Ray Wenderlich. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet weak var nameTextField: NSTextField!
  @IBOutlet weak var welcomeLabel: NSTextField!
  @IBOutlet weak var ballImageView: NSImageView!
  @IBOutlet weak var adviceLabel: NSTextField!
  
  
  @IBAction func handleWelcome(sender: AnyObject) {
    welcomeLabel.stringValue = "Hello \(nameTextField.stringValue)!"
  }
  
  @IBAction func handleBallClick(sender: AnyObject) {
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}

