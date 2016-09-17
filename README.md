# Argonaut

[![Build Status](https://travis-ci.org/aschuch/Argonaut.svg)](https://travis-ci.org/aschuch/Argonaut)
![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)
![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey.svg)

A collection of (reactive) JSON parsing helpers for the [Argo](https://github.com/thoughtbot/Argo) JSON parser.

> The Argonauts were a band of heroes in Greek mythology. Their name comes from their ship, the Argo, named after its builder, Argus.

# Usage

## JSON Parsing

Map JSON responses to instances of your model objects. The model object needs to conform to Argo’s `Decodable` protocol.

```swift
// Create models from Data
let responseData = // ... some JSON Data, e.g. from a network response
let user: User? = decodeData(responseData)
let userDecoded: Decoded<User>? = decodeData(responseData)
```

Arrays of JSON objects are mapped to an array of model instances.

```swift
// Create array of models from Data
let responseData = // ... some JSON Data, e.g. from a network response
let tasks: [Task]? = decodeData(responseData)
let tasksDecoded: Decoded<[Task]>? = decodeData(responseData)
```

### Reactive Cocoa

Argonaut also supports JSON mapping for ReactiveCocoa 4.0 (`Signal and SignalProducer`).

```swift
// Create models from JSON dictionary
let jsonSignalProducer: SignalProducer<Any, NSError> = // ...
jsonSignalProducer.mapToType(User).startWithNext { [weak self] user in
    // use the User model
}

// Create array of models from array of JSON dictionaries
let jsonSignalProducer: SignalProducer<Any, NSError> = // ...
jsonSignalProducer.mapToTypeArray(Task). startWithNext { [weak self] tasks in
    // use the array of Task models
}
```

## Version Compatibility

Current Swift compatibility breakdown:

| Swift Version | Framework Version |
| ------------- | ----------------- |
| 3.0	        | master          	|
| 2.3	        | 3.x          		|
| 2.2           | 2.x          		|

[all releases]: https://github.com/aschuch/Argonaut/releases

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