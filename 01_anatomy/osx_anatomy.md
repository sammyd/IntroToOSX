# Introduction to developing for OS X: Anatomy of an OS X App

## Introduction

In the previous article you discovered how to install Xcode, before running through a brief tour of its major features. In this tutorial you'll turn your attention to OS X apps themselves - specifically how they are architected.

By the end of this article you'll have a good grounding in how the different parts of an OS X app fit together, although not necessarily a wide-ranging understanding of how each of them works.



## Prerequisites

To build apps for OS X, you need a computer running OS X, which means an Apple Mac. You'll also need Xcode installed - if you haven't done this yet, you should take a look at the previous tutorial to learn how to get set up.

## How does an app start?
- Storyboard entry point
- Entry in Info.plist
  + What is info.plist?

## User interface

### Window
- The visualisation of your app on screen
- Represented by `NSWindow`
- Managed by a `NSWindowController`

### View
- Used to draw on the screen
- Represented by `NSView`
- Managed by `UIViewController`
  + Lifecycle
  + Use these a lot

### View components
- Selection of subclasses (maybe mention upcoming catalog?)
- Mention about custom drawing

### Viewing collections
- What are they, how do they work?
- Table view
- Collection view

### Handling user interaction
- Keyboard
- Gestures

### Menu bar
- What is it?
- Menu controller

## Data Layer
- Needed to drive the UI
- Can build your own
- Mention Core Data
- OS X allows you to split it out into a separate framework


## Other useful Cocoa functionality
- Just a couple of sentences about where to look:
  + Networking
  + MapKit & CoreLocation
  + Contacts
  + WebKit

## Where to go from here?
- Next article will introduce UI concepts
- Links to Apple documentation
