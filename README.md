# DeliveryAssignment (iOS)

A prototype of an application which displays deliveries of goods and their delivery details with map location. 

# Installation

To install CocoaPods:-
- Open terminal and type: "sudo gem install cocoapods"
-  After installation, there will be a lot of messages, read them and if no error found, it means cocoapods installation is done. Next, you need to setup the cocoapods master repo. Type in terminal:

To run the project :
- Open podfile from project directory. 
- Open terminal and cd to the directory containing the Podfile.
- Run the "pod install" command.
- if You get any error try running "pod repo update" and then "pod install".
- locate and open the .xcworkspace Xcode project file. (You should no longer open the xcodeproj file)

# Prerequisites
Xcode : 10.2

# Design  Pattern
## MVVM
- Model: Manage and store the data received from server .
- ViewModel: Stands between view and model . All business logic are handled in viewModel. It receives the event form view and interacts with the model. ViewModel execute the logic to update the model based on the event. It also manages data that is to be stored on disk Cache
- View: View and ViewControllers comes under this layer. This layer receives user interaction and send the events to ViewModel layer. It also observe the updation in viewModel and update the UI accordingly. 


![Untitled Diagram](https://user-images.githubusercontent.com/10941262/61352480-1784a400-a88b-11e9-8520-2c5cdf7a27fe.jpg)


# Supported OS version
 iOS (10.x, 11.x, 12.x)  

# Language 
Swift 5.0

# Version
 1.0 

# "Pod Used"      
- Alamofire
- SDWebImage
- Cache
- PKHUD
- OHHTTPStubs/Swift
- SwiftLint
- Firebase/Core'
- Fabric
- Crashlytics

# SwiftLint
- Integration of SwiftLint into an Xcode scheme to keep a codebase consistent and maintainable .
- Install the swiftLint via cocoaPod and need to add a new "Run Script Phase" with:
-"${PODS_ROOT}/SwiftLint/swiftlint"
- .swiftlint.yml file is used for basic set of rules . It is placed inside the project folder.

# Map
- Native Apple map is used.


# Data Caching
- DiskCache is used for data caching. Every time data is fetched from server , it appends the received data into existing one and then replaces it onto disk.
- "Pull to refresh" will fetch data from starting index, and it will clear all previous data stored in local storage.
- when app is opened all the data is loaded from Cache and displayed on the list.

# Firebase "Crashlytics"
-  We need to create account on firebase. Kindly replace "GoogleService-Info.plist" file with your plist file which you can generate while creating an app on firebase.

# Unit Testing
- Unit testing is done by using XCTest.

# Assumptions        
-    The app is designed for iPhones only .       
-   App  supports multi languages , but right now only english language text is displaying.
-    Mobile platform supported: iOS (10.x, 11.x, 12.x)        
-   Device support - iPhone 5s, iPhone 6 Series, iPhone SE, iPhone 7 Series, iPhone 8 Series, iPhone X Series.    
-    iPhone app support would be limited to portrait mode.


# Scope for Improvement
- UITesting

# Screenshots
<img width="413" alt="Simulator Screen Shot - iPhone Xʀ - 2019-07-12 at 14 44" src="https://user-images.githubusercontent.com/10941262/61353890-7ac40580-a88e-11e9-9b10-6818f100298a.png">"

<img width="413" alt="Simulator Screen Shot - iPhone Xʀ - 2019-07-12 at 14 44 45" src="https://user-images.githubusercontent.com/10941262/61353895-7ef02300-a88e-11e9-8f83-6184773a5f6d.png">"

