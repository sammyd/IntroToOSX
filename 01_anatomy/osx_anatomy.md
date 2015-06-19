# Introduction to developing for OS X: Anatomy of an OS X App

## Introduction
- Summary of why from last article
- Outline of what you'll learn

## Prerequisites
- Mac
- OS X
- Xcode
- Link back to previous article about tooling

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



