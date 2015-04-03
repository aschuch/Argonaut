# Argonaut

![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)

A collection of helpers for the [Argo](https://github.com/thoughtbot/Argo) JSON parser.

> The Argonauts were a band of heroes in Greek mythology. Their name comes from their ship, the Argo, named after its builder, Argus.

# Usage

## JSON Parsing

Map JSON responses to instances of your model objects. The model object needs to conform to Argo’s `JSONDecodable` protocol.

```swift
// Create models from NSData
let responseData = // ... some JSON NSData, e.g. from a network response
let user: User = mapJSON(responseData)

// Create models from dictionary
let responseDict = // ... [String: AnyObject]
let user: User = mapJSON(responseDict)
```

Arrays of JSON objects are mapped to an array of model instances.

```swift
// Create array of models from NSData
let responseData = // ... some JSON NSData, e.g. from a network response
let tasks: [Task] = mapJSONArray(responseData)

// Create array of models from array of dictionaries
let responseDict = // ... [[String: AnyObject]]
let tasks: [Task] = mapJSON(responseDict)
```

### Reactive Cocoa

Argonaut also supports JSON mapping on ReactiveCocoa signals.

```swift
// Create models from JSON dictionary
let jsonSignal = // ... emits [String: AnyObject]
jsonSignal.mapToObject(User.self).subscribeNext({ [weak self] user in
    // use the User model
}, error: { error in
    // Error in the ArgonautErrorDomain
    println(error)
})

// Create array of models from array of JSON dictionaries
let jsonSignal = // ... emits [[String: AnyObject]]
jsonSignal.mapToObjectArray(Task.self).subscribeNext({ [weak self] tasks in
    // use the array of Task models
}, error: { error in
    // Error in the ArgonautErrorDomain
    println(error)
})
```

## `JSONDecodeable` Extensions

Argonaut also aims to collect helpful extensions for common objets to be directly used with Argo/Runes. Currently only a handful extensions are supported, but pull requests are more than welcome.

| Class											| Description 						|
|----											|----								|
| [CLLocation](Argonaut/CLLocation+Argo.swift) 	| Converts a JSON dictionary `{"lat": 48.2, "lon": 16.36}` to a `CLLocation`. |
| [NSURL](Argonaut/NSURL+Argo.swift) 			| Converts a JSON string to `NSURL` |

## Installation

#### Carthage

Add the following line to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).

```
github "aschuch/Argonaut”
```

Then run `carthage update`.

#### Manually

Just drag and drop the three `.swift` files in the `Argonaut` folder into your project.

## Tests

Open the Xcode project and press `⌘-U` to run the tests.

Alternatively, all tests can be run from the terminal using [xctool](https://github.com/facebook/xctool).

```bash
xctool -scheme ArgonautTests -sdk iphonesimulator test
```

## Todo

* Update to ReactiveCocoa swift (generic Signal)
* CocoaPods support

## Contributing

* Create something awesome, make the code better, add some functionality,
  whatever (this is the hardest part).
* [Fork it](http://help.github.com/forking/)
* Create new branch to make your changes
* Commit all your changes to your branch
* Submit a [pull request](http://help.github.com/pull-requests/)


## Contact

Feel free to get in touch.

* Website: <http://schuch.me>
* Twitter: [@schuchalexander](http://twitter.com/schuchalexander)
