//
//  SplitViewController.swift
//  HubEvent
//
//  Created by Sam Davies on 06/05/2015.
//  Copyright (c) 2015 razeware. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    splitView.delegate = self
  }
  
  override func viewWillAppear() {
    super.viewWillAppear()
    
    splitView.setPosition(view.bounds.height / 2.0, ofDividerAtIndex: 0)
  }
  
  override func splitView(splitView: NSSplitView, constrainSplitPosition proposedPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
    return view.bounds.height / 2.0
  }
}

extension SplitViewController {
  override var representedObject: AnyObject? {
    didSet {
      for viewController in self.childViewControllers as! [NSViewController] {
        viewController.representedObject = representedObject
      }
    }
  }
}

