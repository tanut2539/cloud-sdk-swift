
# Kentico Cloud swift SDK

[![CI Status](http://img.shields.io/travis/martinmakarsky@gmail.com/KenticoCloud.svg?style=flat)](https://travis-ci.org/martinmakarsky@gmail.com/KenticoCloud)
[![Version](https://img.shields.io/cocoapods/v/KenticoCloud.svg?style=flat)](http://cocoapods.org/pods/KenticoCloud)
[![License](https://img.shields.io/cocoapods/l/KenticoCloud.svg?style=flat)](http://cocoapods.org/pods/KenticoCloud)
[![Platform](https://img.shields.io/cocoapods/p/KenticoCloud.svg?style=flat)](http://cocoapods.org/pods/KenticoCloud)

## Summary
The KenticoCloud iOS SDK is a library used for retrieving content and tracking activities. You can use the SDK in the form of a CocoaPod package or add it manually.

## Prerequisites

To retrieve content from a Kentico Cloud project via the Delivery API, you first need to activate the API for the project. See our documentation on how you can [activate the Delivery API](https://developer.kenticocloud.com/docs/using-delivery-api#section-enabling-the-delivery-api-for-your-projects).


## Quick start
**1. Add pod**  
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'KenticoCloud'
end
```

```bash
$ pod install
```
**2. Create type object** - in this example it is `Article`. This is content type in Kentico Cloud which we want to get items for. This type has three elements with following codenames: `title` (is a text element),`easer_image` (is an asset element),`post_date` (is a DateTime element).
```swift
import ObjectMapper

class Article: Mappable {
    var title: TextElement?
    var asset: AssetElement?
    var postDate: DateTimeElement?
    
    required init?(map: Map){
        let mapper = MapElement.init(map: map)
        title = mapper.map(elementName: "title", elementType: TextElement.self)
        asset = mapper.map(elementName: "teaser_image", elementType: AssetElement.self)
        postDate = mapper.map(elementName: "post_date", elementType: DateTimeElement.self)
    }
    
    func mapping(map: Map) {

    }
 ```
**3. Prepare Delivery client**
```swift
import KenticoCloud

let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID")
 ```
**4. Prepare query**
```swift
let typeQueryParameter = QueryParameter.init(parameterKey: QueryParameterKey.type, parameterValue: "article")
let languageQueryParameter = QueryParameter.init(parameterKey: QueryParameterKey.language, parameterValue: "es-ES")
let articlesQueryParameters = [typeQueryParameter, languageQueryParameter]
 ```
**5. Get and use items**
```swift
client.getItems(modelType: Article.self, customQuery: customQuery) { (isSuccess, deliveryItems, error) in
    if isSuccess {
        if let articles = deliveryItems?.items {
            // use your articles here
        }
    } else {
        if let error = error {
            print(error)
        }
    }
}
 ```

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
 
## Using the DeliveryClient

The `DeliveryClient` class is the main class of the SDK for getting content. Using this class, you can retrieve content from your Kentico Cloud projects.

To create an instance of the class, you need to provide a [project ID](https://developer.kenticocloud.com/docs/using-delivery-api#section-getting-project-id).

```swift
// Initializes an instance of the DeliveryClient client
let cloudClient = DeliveryClient.init("975bf280-fd91-488c-994c-2f04416e5ee3")
```

Once you create a `DeliveryClient`, you can start querying your project repository by calling methods on the client instance. See [Basic querying](#basic-querying) for details.

### Previewing unpublished content

To retrieve unpublished content, you need to create a `DeliveryClient` with both Project ID and Preview API key. Each Kentico Cloud project has its own Preview API key. 

```swift
// Note: Within a single project, we recommend that you work with only
// either the production or preview Delivery API, not both.
import KenticoCloud

let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID")
```

For more details, see [Previewing unpublished content using the Delivery API](https://developer.kenticocloud.com/docs/preview-content-via-api).
 
## Getting items

### Using strongly typed model

In order to receive strongly typed items you need to implement your item model. It's necessary to conform to `Mappable` protocol and implement mapping functionality. You can use your own mapping or our strongly typed element types.

- Element types mapping:
```swift
import ObjectMapper

class Article: Mappable {
    var title: TextElement?
    var asset: AssetElement?
    var postDate: DateTimeElement?
    
    required init?(map: Map){
        let mapper = MapElement.init(map: map)
        title = mapper.map(elementName: "title", elementType: TextElement.self)
        asset = mapper.map(elementName: "teaser_image", elementType: AssetElement.self)
        postDate = mapper.map(elementName: "post_date", elementType: DateTimeElement.self)
    }
    
    func mapping(map: Map) {

    }
 ```
 
 - Custom mapping:
```swift
import ObjectMapper

public class Cafe: Mappable {
    public var city: String?
    public var street: String?
    public var country: String?
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        city <- map["elements.city.value"]
        street <- map["elements.street.value"]
        country <- map["elements.country.value"]
    }
 ```
### Basic items querying 
Once you have a `DeliveryClient` instance, you can start querying your project repository by calling methods on the instance. Yu need to pass your item model and query. You can create query for listing in two ways:
- creating custom string query
```swift
let customQuery = "items?system.type=article&order=elements.post_date[desc]"
client.getItems(modelType: Article.self, customQuery: customQuery) { (isSuccess, deliveryItems, error) in ...
 ```
 - using query parameters array
 ```swift
 let contentTypeQueryParameter = QueryParameter.init(parameterKey: QueryParameterKey.type, parameterValue: contentType)
let languageQueryParameter = QueryParameter.init(parameterKey: QueryParameterKey.language, parameterValue: "es-ES")
let coffeesQueryParameters = [contentTypeQueryParameter, languageQueryParameter]
client.getItems(modelType: Coffee.self, queryParameters: coffeesQueryParameters) { (isSuccess, deliveryItems, error) in ...
 ```
 
 Then you can use your obtained items in completetion handler like:
 
 ```swift
 // Retrieves a list of all content items of certain type
let contentTypeQueryParameter = QueryParameter.init(parameterKey: QueryParameterKey.type, parameterValue: "coffee")
let coffeesQueryParameters = [contentTypeQueryParameter]
client.getItems(modelType: Coffee.self, queryParameters: coffeesQueryParameters) { (isSuccess, deliveryItems, error) in
        if isSuccess {
            if let coffees = deliveryItems?.items {
                // Use your items here
            }
        } else {
            if let error = error {
                print(error)
            }
        }
```

You can also retrieve just a single item

```swift
// Retrieves a single content item
let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID")
client.getItem(modelType: Cafe.self, itemName: "boston") { (isSuccess, deliveryItem, error) in
    if isSuccess {
        if let cafe = deliveryItem.item {
            // Use your item here
        }
    } else {
        if let error = error {
            print(error)
        }
    }
}
```
### Get modular content
You can get modular content from `itemResponse` or `itemsResponse` object like:
```swift
let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID")
client.getItem(modelType: Article.self, itemName: "on_roasts", completionHandler: { (isSuccess, itemResponse, error) in
	if isSuccess {
		let relatedArticle = itemResponse?.getModularContent(codename: "on_roasts", type: Article.self)
	}
}
                            
                         
```

## Getting taxonomies

### Get taxonomy group
```swift
let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID")
client.getTaxonomyGroup(taxonomyGroupName: "personas", completionHandler: { (isSuccess, deliveryItem, error) in
   if isSuccess {
       if let taxonomyGroup = deliveryItems.item {
        // use your taxonomy group here
       }
    } else {
         if let error = error {
             print(error)
         }
    }
})
```

### Get all taxonomies
```swift
let client = DeliveryClient.init(projectId: "YOUR_PROJECT_ID")
client.getTaxonomies(completionHandler: { (isSuccess, deliveryItems, error) in
   if isSuccess {
       if let taxonomies = deliveryItems?.items {
        // use your taxonomies here
       }
    } else {
         if let error = error {
             print(error)
         }
    }
})
```

## Using the TrackingClient
In order to log custom activities and add contacts you need to start session first.

### Create session
```swift
let client = TrackingClient.init(projectId: "YOUR_PROJECT_ID")
client.startSession()
```
### Log custom activity
```swift
client.trackActivity(activityName: "madrid")
```
### Add contact
```swift
client.addContact(email: "martinkoklingacik@local.com")
```

## Debug
If you want to view debug info from both clients set client's `enableDebugLogging` attribute
```swift
let deliveryClient = DeliveryClient.init(projectId: "YOUR_PROJECT_ID", enableDebugLogging = true)
let trackingClient = TrackingClient.init(projectId: "YOUR_PROJECT_ID", enableDebugLogging = true)
```
## Further information

For more developer resources, visit the Kentico Cloud Developer Hub at <https://developer.kenticocloud.com>.

## Feedback & Contributing

Check out the [contributing](https://github.com/Kentico/cloud-sdk-swift/blob/master/CONTRIBUTING.md) page to see the best places to file issues, start discussions, and begin contributing.

## License

KenticoCloud is available under the MIT license. See the LICENSE file for more info.
