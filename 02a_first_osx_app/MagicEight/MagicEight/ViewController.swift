/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

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
      if let advice = adviceList.randomElement {
        adviceLabel.stringValue = advice
        // 2:
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

