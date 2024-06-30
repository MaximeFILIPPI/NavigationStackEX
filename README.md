

<p align="center">
  <img src="https://github.com/MaximeFILIPPI/NavigationStackEX/blob/main/Images/navigation_stack_banner.png" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/SwiftUI-5%2B-blue?style=flat&color=%2326c281%20&link=https%3A%2F%2Fdeveloper.apple.com%2Fxcode%2Fswiftui%2F" />
    <img src="https://img.shields.io/badge/iOS-16%2B-blue?style=flat&color=%239f5afd&link=https%3A%2F%2Fdeveloper.apple.com%2Fios%2F" alt="Platforms" />
    <a href="https://github.com/MaximeFILIPPI/NavigationStackEX/blob/main/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>

# NavigationStackEX

Abstract encapsulation of the default NavigationStack with custom functionalities aimed at simplifying SwiftUI view management and navigation. 

Push, present, and pop your views elegantly, helping you reduce time, complexity, and maintain code clarity.



## Features

✅ 100% SwiftUI

✅ Super easy-to-use

✅ Powerful solution for your Navigation

✅ Can predefine the loading of your views in the app ahead of use in a more classical way

✅ Can dynamically push / present your Views in a SwiftUI style, more modern way

✅ Supports any kind of Views


⚠️ Known limitation: The display of modal views (for 'present' and 'presentFullScreen') are not stackable as of right now (will be in the future)


## Requirements

- iOS 16.0+
- SwiftUI 5.0+



## Installation

**Swift Package Manager:**

`XCode` > `File` > `Add Package Dependency...`  

Enter the following `URL` of the repository into the search: 
```html
https://github.com/MaximeFILIPPI/NavigationStackEX
```
Follow the prompts to complete the installation.


## Setup

Here is an example of how to integrate and use NavigationStackEX in your SwiftUI views:

```swift
import SwiftUI
import NavigationStackEX // <- Import
    
@main
struct NameOfYourProject: App {
    
    @State var segues: [String: AnyView] = [:] // <- Add this line to prepare destinations routes
    
    var body: some Scene {
    
        WindowGroup {
        
            NavigationStackEX(destinations: $segues) { // <- The Navigation with the destinations in binding
                ContentView()
            }
            .onAppear {
                self.setupNavigation()
            }
        }
    }
    
    
    // OPTIONAL
    // You can setup the destinations ahead of time 
    // By predefining your views with associated tags
    // if you wish to navigate in a more classical way by referencing tags instead of views instance (UIKit style) 
    func setupNavigation()
    {
        // Example for a profile view in your app
        self.segues["profile"] = ProfileView().any // <- add .any modifier behind your view
        
        // Add more segues as needed
    }
}
```




## Basic Usage

To navigate between your views, simply add `@EnvironmentObject var navigator: Navigator` to them, then use the `navigator` functions as `push`, `present`, `presentFullScreen`, `pop`, `popToRoot`, `dismiss` to trigger the navigation:

```swift
import SwiftUI
import NavigationStackEX

struct ContentView: View {

    @EnvironmentObject var navigator: Navigator  // <- Add this line
    
    var body: some View {
    
        VStack {
        
            Button("Go to Profile") {
            
            navigator.push(to: ProfileView()) // <- Push your view directly (or you can use a tag like "profile" that was predefine in the setupNavigation() function)
            
            }
            
        }
        
    }
    
}
```



## Detailed Usage


**PUSH**

Navigate to next screen (Modern style)

```swift

// Navigate to a SwiftUI view instance
navigator.push(to: ProfileView())


```


Navigate to next screen (Classic style)

```swift

// Navigate to a destination 
navigator.push(to: "profile")


```


**POP**

Back to previous screen

```swift

// Back to the previous SwiftUI view
navigator.pop()


```


Back to the root of your navigation (very first screen)

```swift

// Back to the previous SwiftUI view
navigator.popToRoot()


```


Back to a specific screen 
You must use the classical way OR add the "identifier" parameter behind your view instance when using `push`
(example: `navigator.push(to: ProfileView(), identifier: "profile"))`)

```swift

// Back to a specified SwiftUI view
navigator.pop(to: "profile") // <- will take you back to the profile view of your app, wherever it is in your navigation stack


```



**PRESENT**

> **Note**
> Be careful the present modal way of displaying views is not stackable at the moment.


Modal opening screen (Modern style)

```swift

// Navigate to a SwiftUI view instance
navigator.present(ProfileView())


```


Modal opening screen (Classic style)

```swift

// Navigate to a destination 
navigator.present("profile")


```

Cover opening full screen  (Modern style)

```swift

// Navigate to a SwiftUI view instance
navigator.presentFullScreen(ProfileView())


```


Modal opening screen (Classic style)

```swift

// Navigate to a destination 
navigator.presentFullScreen("profile")


```




## Passing Data 

How to pass data in the classical way: 

/ Show Implemetation of passing and retrieve data in the classical way: *TO BE COMPLETED */


How to pass data in the modern way: 

/ Show Implemetation of passing in the modern way: *TO BE COMPLETED */



## Customization

You can change the back button of the navigation bar if you wish:

```swift
import SwiftUI
import NavigationStackEX

struct SecondScreenView: View {
    
    var body: some View {
        ZStack {
            Color.red
        }
        .navigationBackButtonItem(Text("Back")) // Customize back button if needed (can be any view)
    }
}
```


or the left / right navigation bar items :

```swift
import SwiftUI
import NavigationStackEX

struct SecondScreenView: View {
    
    var body: some View {
        ZStack {
            Color.red
        }
        .navigationLeftViewItem(CustomBackButtonView()) // <- Right navigation bar button
        .navigationRightViewItem(CustomLogoView()) // <- Left navigation bar button
    }
}
```


Change the way the title is diplayed (Large or Inline)

```swift
import SwiftUI
import NavigationStackEX

struct SecondScreenView: View {
    
    var body: some View {
        ZStack {
            Color.red
        }
        .navigationTitle("Title")
        .navigationBarHidden(false)
        .toolbarTitleDisplayMode(.large) // Large or Inline for better user experience (avoid using automatic)
    }
}
```


or not displayed at all and hide the navigation bar: 
        
```swift
import SwiftUI
import NavigationStackEX

struct SecondScreenView: View {
    
    var body: some View {
        ZStack {
            Color.red
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
```



## Examples

Please refer to the directory [EXAMPLES](https://github.com/MaximeFILIPPI/NavigationStackEX/tree/main/Examples) for fully detailed code on how to achieve certain effects.


/ Show a complete example: *TO BE COMPLETED */



## License

SnapPager is available under the MIT license. See the [LICENSE](https://github.com/MaximeFILIPPI/NavigationStackEX/blob/main/LICENSE) file for more details.


## Credits

**NavigationStackEX** is developed and maintained by [Maxime FILIPPI].

If you encounter any issues or have suggestions for improvements, please [open an issue](https://github.com/MaximeFILIPPI/NavigationStackEX/issues).

