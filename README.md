
# KenticoCloud

[![CI Status](http://img.shields.io/travis/martinmakarsky@gmail.com/KenticoCloud.svg?style=flat)](https://travis-ci.org/martinmakarsky@gmail.com/KenticoCloud)
[![Version](https://img.shields.io/cocoapods/v/KenticoCloud.svg?style=flat)](http://cocoapods.org/pods/KenticoCloud)
[![License](https://img.shields.io/cocoapods/l/KenticoCloud.svg?style=flat)](http://cocoapods.org/pods/KenticoCloud)
[![Platform](https://img.shields.io/cocoapods/p/KenticoCloud.svg?style=flat)](http://cocoapods.org/pods/KenticoCloud)

## Summary
The KenticoCloud iOS SDK is a library used for retrieving content and tracking activities. You can use the SDK in the form of a CocoaPod package or manually.

## Prerequisites

To retrieve content from a Kentico Cloud project via the Delivery API, you first need to activate the API for the project. See our documentation on how you can [activate the Delivery API](https://developer.kenticocloud.com/docs/using-delivery-api#section-enabling-the-delivery-api-for-your-projects).

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate KenticoCloud into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'KenticoCloud'
end
```

Then, run the following command:

```bash
$ pod install
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

KenticoCloud is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "KenticoCloud"
```

## Author

martinm@kentico.com

## License

KenticoCloud is available under the MIT license. See the LICENSE file for more info.
