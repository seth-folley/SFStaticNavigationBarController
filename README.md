# SFStaticNavigationBarController

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat-square
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat-square
)](https://developer.apple.com/swift)
[![Version](https://img.shields.io/cocoapods/v/SFStaticNavigationBarController.svg?style=flat-square)](http://cocoapods.org/pods/SFStaticNavigationBarController)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square
)](http://mit-license.org)

<img src="/docs/example1.gif" align="right" height="560px">

## Description
`SFStaticNavigationBarController` is a custom `UINavigationController` with a static navigation bar.
- A custom navigation bar with 3 possible states and an indicator for these states
- Transitions from left and from right based on what position you are in and where are you navigating to

## Requirements
- iOS 9.0+
- Swift 3.2
- Currently only supports Portrait Orientations

## Installation
SFStaticNavigationBarController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SFStaticNavigationBarController'
```

## Usage
### Initializing
```swift
let staticNavBarController = StaticNavigationBarController(centerViewController: myCenterViewController)
```
### Setting View Controllers and Nav Bar Items
```swift
staticNavBarController.leftViewController = SomeOtherCenterViewController()
staticNavBarController.leftViewController = MyLeftViewController()
staticNavBarController.rightViewController = MyRightViewController()

staticNavBarController.leftBarButtonItem = SomeUIBarButtonItem()
staticNavBarController.rightBarButtonItem = SomeUIBarButtonItem()
staticNavBarController.centerItem = SomeUIView()
```
### Accessing the Nav Controller
You can access this navigation controller as you normally would using `myViewController.navigationController`. Also, available to all view controllers is:
```swift
var staticNavigationBarController: StaticNavigationBarController?
```
### Navigation Functions
`SFStaticNavigationBarController` has the same navigation functions has a regular `UINavigationController`. For clarity, `func popToRootViewController(animated: Bool) -> [UIViewController]?` pops to `centerViewController`.

### Transition Animations
Currently, custom view controller transition animations are not supported. The default transition animations are "natural" depending on what the active position is. Push and pop transitions are also "natural."
Accessible variables pertaining to transition animations are:
```swift
var shouldAnimateTransitions: Bool
var transitionDuration: TimeInterval // default is 0.3s
```

### Navigation Bar Slider
You can customize the slider in the navigation bar using `someStaticNavBarController.staticNavigationBar.slider`. Below are
the available variables to adjust.
```swift
var leftMargin: CGFloat // default: 8.0
var leftSize: CGSize: // default: CGSize(width: 35.0, height: 2)
var centerSize: CGSize // default: CGSize(width: 35.0, height: 2)
var rightMargin: CGFloat // default: 8.0
var rightSize: CGSize // default: CGSize(width: 35.0, height: 2)
var color: UIColor // default: .darkGray
```

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## TODO
- [ ] improve README
- [ ] Write Tests
- [ ] Animation for navigation bar color changes
- [ ] Different slider animations
- [ ] More customization to slider

## Author
crystalSETH, sethfolley@gmail.com

## License

SFStaticNavigationBarController is available under the MIT license. See the LICENSE file for more info.
