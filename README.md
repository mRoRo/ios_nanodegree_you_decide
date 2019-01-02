# Flight info
This app was created as a final project of the [“iOS Developer Nanodegree” Nanodegree program from Udacity](https://www.udacity.com/course/ios-developer-nanodegree--nd003).

## Objective of the app
This app informs the user about flight states and locations.

## How to use the app
After the app is launched, a map is show. 

The user will need to long press the map in order to select a reference location and find near flights. To update the near flights the user must tap the refresh button.

If the user taps a flight marker and the info button, the flight info will be shown.

## Learning purposes
I've applied Clean Architecture and used RxSwift and RxAlamofire frameworks

## Build and install
### Requirements
* Xcode 10.1
* iOS 12.1
* Swift 4.2

### Getting the code
To download the code, you'll have to clone the repo. Then, to install RxSwift and RxAlamofire frameworks, you'll need to use CocoaPods, so please execute a ‘pod install’ command in the same path the PodFile is located to download all the third-party frameworks:
```
pod install
```

### Running the app
After executing ‘pod install’, open the `Flight Info.xcworkspace` file that has been generated instead of  `Flight Info.xcodeproj` with XCode.
All the flight data is provided by the Flightstats API the app. You'll nedd to add an application ID and an Application Key to use the Flightstats API. Open 
`FSClientConstants.swift` in Xcode and add them

```
// MARK: Flight Status Parameter Values ->> ADD YOUR VALUES
struct ParameterValues {
static let AppId = ""
static let AppKey = ""
}
```

## Resources
This app uses the following frameworks and APIs:

### Third-party frameworks

| Framework | Description |
| --- | --- 
| [CocoaPods](https://github.com/CocoaPods/CocoaPods) | The Cocoa Dependency Manager. |
| [RxSwift](https://github.com/ReactiveX/RxSwift) | Reactive Programming in Swift. |
| [RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire) | RxSwift wrapper around the elegant HTTP networking in Swift Alamofire. |

### APIs
| Framework | Description |
| --- | --- |
| [FlightStats API](https://developer.flightstats.com/) | It is used to retrieve the information about the flights. |


## License
The contents of this repository are covered under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/).
