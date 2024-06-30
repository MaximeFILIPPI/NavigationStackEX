

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
    
    @State var destinations: [String: AnyView] = [:]
    
    var body: some Scene {
    
        WindowGroup {
        
            NavigationStackEX(destinations: $destinations) {
                ContentView()
            }
            .onAppear {
                self.setupNavigation()
            }
        }
    }
    
    
    // Setup the destinations in a classical way (optional)
    func setupNavigation()
    {
        self.destinations["TagOfYourScreen"] = FirstScreenView().any  // <- add .any modifier behind your view
        self.destinations["TagOfYourSecondScreen"] = SecondScreenView().any
        // Add more destinations as needed
    }
}
```

/ EXEMPLANATION: *TO BE COMPLETED* /



## Basic Usage

To integrate NavigationStackEX into your views:

```swift
import SwiftUI
import NavigationStackEX

struct ContentView: View {
    @EnvironmentObject var navigator: Navigator
    
    var body: some View {
        VStack {
            Button("Go to Profile") {
                navigator.push(to: "profile")
            }
        }
        .navigationBackButtonItem(Text("Back")) // Customize back button if needed
    }
}
```


## Detailed Usage

```swift
// Function to navigate to the next screen view (classical way)
func goToFirstScreenView()
{
    navigator.push(to: "TagOfYourScreen")
}
```

or if you prefer in a more modern way (SwiftUI Style)

```swift
// Function to navigate to the next screen view (modern way)
func goToFirstScreenView()
{
    navigator.push(to: FirstScreenView())
}
```

/ Show pop - pop(to:) - popToRoot: *TO BE COMPLETED */

/ Show Implemetation of present and fullscreen: *TO BE COMPLETED */

> **Note**
> Be careful the modal display of view are not stackable for the moment.



## Passing Data 

How to pass data in the classical way: 

/ Show Implemetation of passing and retrieve data in the classical way: *TO BE COMPLETED */


How to pass data in the modern way: 

/ Show Implemetation of passing in the modern way: *TO BE COMPLETED */



## Customization

You can change the back button if you wish:

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


or the left / right navigation bar buttons:

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


Change the way the title is diplayed (Large or Inline) or not displayed at all 
(it works the same way as the classical NavigationStack)

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


Hide the navigation bar: 
        
        
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

