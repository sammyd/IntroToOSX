# Introduction to developing for OS X: Your First App

## Introduction
- UI very important
- Should build as much as possible in Storyboards
- Outline

## Prerequisites
- Mac
- OS X
- Xcode
- Link to tooling

## Creating the Project

Open Xcode and click __Create a new Xcode project__ to start your new app. Choose __OS X \ Application \ Cocoa Appliction__:

![Project Template](img/project_template.png)

Set the product name __gifMe__, the language to __Swift__ and ensure that the __Use Storyboards__  is checked:

![Project Options](img/project_options.png)

Choose a location on disk to save your project and then click __Create__ to open your empty project.

Build and run __gifMe__ to check that everything is working:

![1st Build and Run](img/bar_01.png)

Great - so the app runs, but it does _absolutely nothing_ yet. In the next section you're going to build the data layer that will perform the GIF searches.


## Data Layer

The data layer is responsible for querying the giphy API with a search term, and then returning the results in a useful form.

To start, you're going to create a Swift struct that will model each search result.

__Right click__ on the yellow __gifMe__ group, and use the menu to create a new group:

![Create Group](img/create_group.png)

Call this group __Data Layer__. Right click on this new group, and select __New File...__:

![New File](img/new_file.png)

Choose __OS X \ Source \ Swift File__ and call the new file __Giphy.swift__:

![Create Giphy.swift](img/create_file_giphy.png)

Add the following code to this new file:

```swift
struct GiphyItem {
  let id: String
  let caption: String
  let url: NSURL
}
```

This defines a struct with three different properties - `id` is a unique string returned by giphy, the caption is string associated with the item and `url` is the location the GIF can be downloaded from. For an app as simple as __gifMe__, this is all you need in your data model - sweet, huh?

### JSON Parsing

The giphy API returns JSON, and you need to convert this into your new `GiphyItem` structs. Rather than write all the guts of this code yourself, you're going to use a simple library called __SwiftyJSON__ to do the heavy lifting.

Download __SwiftyJSON.swift__ and drag it from Finder into the __Data Layer__ group in your Xcode project. When asked, ensure that __Copy items if needed__ is checked:

![Adding SwiftyJSON](img/adding_swifty.png)

This adds the __SwiftyJSON__ functionality, which will make parsing the giphy JSON a lot easier.

You can now add an initializer for `GiphyItem` that accepts a `JSON` object. Copy the following into __Giphy.swift__:

```swift
extension GiphyItem {
  init?(json: JSON) {
    guard let id = json["id"].string,
      let caption = json["caption"].string,
      let urlString = json["images"]["fixed_height"]["url"].string,
      let url = NSURL(string: urlString) else {
        return nil
    }
    self.init(id: id, caption: caption, url: url)
  }
}
```

This code creates a new initializer for `GiphyItem` that extracts the relevant fields from a `JSON` object. __SwiftyJSON__ provides the functionality that allows you to use subscripting to extract data from a JSON object.

Next you need to create a function that will perform the search - querying the giphy API and returning an array of `GiphyItem` results. In order to assist with this, you need to add another file to your project. This file contains helper functions to construct the giphy API URL for a given search term, and to convert the returned JSON into an array of `GiphyItem` objects.

Download __GiphyUtils.swift__, and drag it from the finder into the __Data Layer__ group. Once again, ensure that __Copy items if needed__ is checked.

You can now construct a function that will perform the API query.

Add the following code to __Giphy.swift__:

```swift
func searchGiphy(searchTerm: String, resultHandler: (GiphySearchResult) -> ()) {
  // 1:
  guard let url = urlForSearchTerm(searchTerm) else {
    print("Error creating the search URL")
    return
  }
  // 2:
  let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
    (data, response, error) in
    if let error = error {
      print("Error: \(error.localizedDescription)")
      resultHandler(GiphySearchResult.Error(error))
      return
    }
    // 3:
    let json = JSON(data: data!)
    // 4:
    let giphyItems = convertJSONToGiphyItems(json)
    // 5:
    resultHandler(GiphySearchResult.Result(giphyItems))
    
  })
  // 6:
  task?.resume()
}
```

1. `urlForSearchTerm(_:)` is a function provided by __GiphyUtils.swift__. It generates the correct URL for the given search term. The `guard` statement ensures that a URL was successfully returned.
2. Requesting data from the network involves creating an asynchronous task, using the URL and a closure that defines what happens when the task completes.
3. __JSON__ is the main type within __SwiftyJSON__. It's initialized with the data received from the giphy API.
4. `convertJSONToGiphyItems(_:)` is another function provided by __GiphyUtils.swift__. It uses the custom initializer for `GiphyItem` you created earlier to generate an array of `GiphyItem` structs.
5. Since this is an asynchronous function, rather than returning the result, you provide it via a callback function.
6. Once you've created the task, calling `resume()` will start the network request.

Note that this method doesn't return any values. This is because the network request is an asynchronous process, so instead you provide a `resultHandler` closure that gets called once the request has completed (see step 5).

You've now created a model to represent the search results, and a function that will query the giphy API with a search term. That's it for the data layer - time to move your attention to the UI!


## User Interface




## Where to go from here
- Summarise what you've learnt in these tutorials
- Mention that we'll have loads of new content as part of the OS X team
- Link to Apple's documentation
