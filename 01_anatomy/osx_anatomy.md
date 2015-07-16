# Introduction to developing for OS X: Anatomy of an OS X App

## Introduction

In the previous article you discovered how to install Xcode, before running through a brief tour of its major features. In this tutorial you'll turn your attention to OS X apps themselves - specifically how they are architected.

By the end of this article you'll have a good grounding in how the different parts of an OS X app fit together, although not necessarily a wide-ranging understanding of how each of them works.



## Prerequisites

To build apps for OS X, you need a computer running OS X, which means an Apple Mac. You'll also need Xcode installed - if you haven't done this yet, you should take a look at the previous tutorial to learn how to get set up.

## How does an app start?

Your journey through an OS X app starts right at the beginning - looking at how an app actually _starts_.

There are three components that you need to be aware of when considering the OS X app start process:

- __App Delegate__ The entry point for code. The App Delegate provides methods associated with both the lifecycle of the app, and its interaction with the operating system. This is your first opportunity to run code, and provides you with notifications from OS X, such as Handoff requests, command line arguments and push notifications.
- __Storyboard__ Storyboards have a designated "entry point", and this allows the system to construct the UI at app launch. The entrypoint looks like an arrow on the left hand side of a scene:
![Storyboard Entry](img/storyboard_entry.png)
This denotes which of the scenes in the storyboard will form the initial UI of your app.
- __Info.plist__ You can have multiple storyboards within your app, so how does OS X know which one it should use as the initial UI? This information (and a load of other useful things) is stored inside the __Info.plist__ file.  You can see the relevant entry below:
![Info.plist](img/info_plist.png)
This file contains lots of useful app configuration options, many of which are exposed through the target configuration screen in Xcode. The image below shows the same storyboard setting in a more user-friendly location:
![Project Config](img/project_config.png)

Starting an app is _slightly_ more complicated than this, but these three places explain where you can interact and configure your app's startup. Now that you've got your app up and running it's time to take a look at a very important aspect - its User Interface. 


## User interface

You're already aware of the fact that the UI can be provided by a storyboard, but what does this actually mean? In this section you'll cover the different UI components - what they represent and how they fit together.

TK: DIAGRAM

### Window

The UI for your app will be contained within one or more window objects. These represent an area of the screen for which your app is responsible for providing the UI. The operating system runs a window manager that handles the moving and resizing of these windows, updating your app as the user makes these changes.

In addition to representing the visualization of your app, the window object also handles passing user events triggered by user interaction with the mouse and keyboard into your app.

Although you can interact directly with a window object, often they're managed by window controllers - especially when used in conjunction with storyboards.

A window controller is responsible for the loading of the window itself, and allows you to hook into different events throughout the lifecycle of the window.

A storyboard would contain at least one window controller, which is represented as follows:

![Window Controller](img/window_controller.png)

Window controllers are represented by the `NSWindowController` class, and as you configure your different windows, you would normally create different subclasses to manage their individual behavior.

### Views

The window specifies the area of the screen that your app is responsible for drawing on, but not what to draw. This is one of the primary responsibilities of the view - providing you with functionality to draw on the screen.

Views are rectangular in shape, and are represented by the `NSView` class. Views exist within a hierarchy - i.e. any view can contain zero or more subviews - allowing you to construct a complex layout using much simpler, reusable view components.

#### View Controllers

In the same way that windows are managed by a window controller in storyboards, views are managed by a view controller class. This links the view hierarchy in with the the model layer, either by manipulating properties directly, or through Cocoa bindings.

In a typical application, a view controller is a reusable component that, when provided a model object of a particular type, would update all of its constituent views to represent the values of its associated model object.

TK: For example....

View controllers are represented by `UIViewController`, which provides a full range of lifecycle events - allowing you to perform custom actions at different times. For example you can fire animation as the view is about to appear on the screen with `viewWillAppear()`, or populate relevant views with data once the view hierarchy has correctly loaded with `viewDidLoad()`.

Your app is likely to be formed from a selection of custom subclasses of `UIViewController`, each responsible for a different section of a window. They're an incredibly important aspect of an app - forming the link that allows you to display the underlying data to the user.


### View components

You've discovered that views are used to draw on the screen - but how is that actually achieved? At the lowest level you can create a custom subclass of `NSView` and override the `drawRect()` method to manually draw the content of your view.

This is extremely powerful - allowing you to create completely custom views, but would be arduous if you had to do this to draw some text on the screen!

Luckily, you don't have to. AppKit contains a large selection of commonly used `NSView` subclasses that you can use to display content on the screen.

Some of the most useful examples are:

- __Label__ Displays static text. Configurable font and appearance
![Label](img/label.png)
- __Text Field__ User-editable text control. Used to collect a string from the user.
![Text Field](img/text_field.png)
- __Image View__ Draws an image - provided by an `NSImage` object.
![Image View](img/image_view.png)
- __Push Button__ One of the many button types - each of which respond to a user's mouse click.
![Push Button](img/push_button.png)
- __Table View__ An example of one of the many view subclasses used for showing not just _one_ data object, but rather a collection of them.
![Table View](img/table_view.png)

These are just a few of the different view subclasses available to you as you build up the user interface of your app. You can discover the entire range in the object library within Interface Builder:

![Object Library](img/object_library.png)

The RayWenderlich.com OS X tutorial team will also be putting together a quick reference guide to different UI components over the coming months - so be sure to check back for that.

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
