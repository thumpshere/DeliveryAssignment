# DeliveryAssignment (iOS)

An application which displays deliveries of goods and their delivery details with  location and address on map. 

# Installation

To install CocoaPods:-
- Open terminal and type: "sudo gem install cocoapods"
-  After installation, there will be a lot of messages, read them and if no error found, it means cocoapods installation is done.

To run the project :
- Open podfile from project directory. 
- Open terminal and cd to the directory containing the Podfile.
- Run the "pod install" command.
- If You get any error try running "pod repo update" and then "pod install".
- Locate and open the .xcworkspace Xcode project file. (You should no longer open the xcodeproj file)

# Prerequisites
Xcode : 10.2

# Design  Pattern
## MVVM
- Model: Manage and store the data received from server .
- ViewModel: Stands between view and model . All business logic are handled in viewModel. It receives the event form view and interacts with the model. ViewModel execute the logic to update the model based on the event. It also manages data that is to be stored on disk Cache
- View: View and ViewControllers comes under this layer. This layer receives user interaction and send the events to ViewModel layer. It also observe the updation in viewModel and update the UI accordingly. 


<img width="971" alt="Screenshot 2019-07-18 at 4 16 02 PM" src="https://user-images.githubusercontent.com/10941262/61451661-7f181d80-a977-11e9-9943-879de9385058.png">


# Implementation

- This app is implemented in MVVM design pattern.
- The DeliveryDetail page displays the list of deliveries onto a table. 
- All the data is writtten and fetched at once from disk cache.
- At Initial stage first 20 records are fetched and displayed on the list.
- When you scroll to end of the page it starts fetching next 20 deliveries and so on.
- The termination for retries of fetching next deliveries is not applied.
- Clicking on a delivery will take on a delivery detail page which shows delivery location on map and details on bottom of the screen.


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
- Install the swiftLint via cocoaPod and need to add a new "Run Script Phase" with:"${PODS_ROOT}/SwiftLint/swiftlint"
- .swiftlint.yml file is used for basic set of rules . It is placed inside the project folder.

# Map
- Native Apple map is used.


# Data Caching
- DiskCache is used for data caching. Every time data is fetched from server , it appends the received data into existing one and then replaces it onto disk.
- "Pull to refresh" will fetch data from starting index, and once the new data is received it will clear all previous data stored in local storage and write the newly received data.
- When app is opened all the data is loaded from Cache and displayed on the list.
- Because the Cache doesnt support queries, Offline pagination is not available and all the stored data is loaded at once.

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
-   No termination condition for paging is applied 


# Scope for Improvement
- UITesting

# Screenshots
<img width="413" alt="Simulator Screen Shot - iPhone Xʀ - 2019-07-12 at 14 44" src="https://user-images.githubusercontent.com/10941262/61353890-7ac40580-a88e-11e9-9b10-6818f100298a.png">"

<img width="413" alt="Simulator Screen Shot - iPhone Xʀ - 2019-07-12 at 14 44 45" src="https://user-images.githubusercontent.com/10941262/61353895-7ef02300-a88e-11e9-8f83-6184773a5f6d.png">"

