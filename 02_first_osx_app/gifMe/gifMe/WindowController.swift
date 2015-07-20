//
//  WindowController.swift
//  gifMe
//
//  Created by Sam Davies on 20/07/2015.
//  Copyright © 2015 RayWenderlich. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
  
  @IBOutlet weak var searchField: NSSearchField!
  
  @IBAction func handleSearch(sender: AnyObject) {
    if let vc = contentViewController as? ViewController {
      searchGiphy(searchField.stringValue) {
        result in
        switch result {
        case .Error(let error):
          print(error.localizedDescription)
        case .Result(let giphyItems):
          dispatch_async(dispatch_get_main_queue()) {
            vc.giphyItems = giphyItems
          }
        }
      }
    }
  }
  
  
  
  override func windowDidLoad() {
    super.windowDidLoad()
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
  }
  
}
