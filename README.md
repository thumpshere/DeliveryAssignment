# DeliveryAssignment (iOS)

An application which displays deliveries of goods and their delivery details with location and address on a map. 

# Installation

To install CocoaPods:-
- Open terminal and type: "sudo gem install cocoapods"
-  After installation, there will be a lot of messages, read them and if no error found, it means cocoapods installation is done.

To run the project :
- Open podfile from project directory. 
- Open terminal and cd to the directory containing the Podfile.
- Run the "pod install" command.
- If you get any error try running "pod repo update" and then "pod install".
- Locate and open the .xcworkspace Xcode project file. (You should no longer open the xcodeproj file)

# Prerequisites
Xcode: 10.2

# Design  Pattern
## MVVM
- Model: Manage the data received from the server and the data stored in Cache. 
- ViewModel: Stands between view and model . All business logic are handled in viewModel. It receives the event from view and interacts with the model. ViewModel executes the logic to update the model based on the event. It also manages data that is to be stored on disk Cache
- View: View and ViewControllers comes under this layer. This layer receives user interaction and sends the events to ViewModel layer. It also observes the updation in viewModel and updates the UI accordingly. 


<img width="963" alt="Screenshot 2019-07-19 at 12 10 11 PM" src="https://user-images.githubusercontent.com/10941262/61514701-38c9c980-aa1e-11e9-87ee-942ff4efccc7.png">



# Implementation

- This app is implemented in MVVM design pattern.
- The DeliveryList page displays the list of deliveries onto a table. 
- All the data is written and fetched at once from disk cache.
- At Initial stage first 20 records are fetched from server and displayed on the list.
- When you scroll to the end of the page it starts fetching next 20 deliveries from the server and so on.
- The maximum limit is not clear hence, the app will try to fetch next 20 records from the server when scrolled to bottom.
- Clicking on a delivery will take on a delivery detail page which shows delivery location on map and details on the bottom of the screen.


# Data Caching
- DiskCache is used for data caching. Whenever data is fetched from the server , it appends the received data into the existing one and then replaces it onto disk.
- "Pull to refresh" will fetch data from starting index, and once the new data is received it will clear all previous data stored in local storage and write the newly received data.
- When the app is opened all the data is loaded from Cache and displayed on the list.
- Because the Cache doesn't support queries, Offline pagination is not available and all the stored data is loaded at once.

# Assumptions        
-    The app is designed for iPhones only.       
-   App supports multiple languages , but right now only English language text is displaying.
-    Mobile platform supported: iOS (10.x, 11.x, 12.x)        
-   Device support - iPhone 5s, iPhone 6 Series, iPhone SE, iPhone 7 Series, iPhone 8 Series, iPhone X Series.    
-    iPhone app support would be limited to portrait mode.
-   Since there was no clarity on the maximum number of deliveries, it will look for the next 20 deliveries every time the user scrolls at the end. 


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
- Integration of SwiftLint into an Xcode scheme to keep a codebase consistent and maintainable.
- Install the swiftLint via cocoaPod and need to add a new "Run Script Phase" with:"${PODS_ROOT}/SwiftLint/swiftlint"
- .swiftlint.yml file is used for basic set of rules. It is placed inside the project folder.

# Map
- Native Apple map is used.

# Firebase "Crashlytics"
-  We need to create an account on firebase. Kindly replace "GoogleService-Info.plist" file with your plist file which you can generate while creating an app on firebase.

# Unit Testing
- Unit testing is done by using XCTest.


# Scope for Improvement
- UITesting

# Screenshots
<img width="413" alt="Simulator Screen Shot - iPhone Xʀ - 2019-07-12 at 14 44" src="https://user-images.githubusercontent.com/10941262/61353890-7ac40580-a88e-11e9-9b10-6818f100298a.png">"

<img width="413" alt="Simulator Screen Shot - iPhone Xʀ - 2019-07-12 at 14 44 45" src="https://user-images.githubusercontent.com/10941262/61353895-7ef02300-a88e-11e9-8f83-6184773a5f6d.png">"

