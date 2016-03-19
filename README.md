[![Build Status](https://travis-ci.org/lightsprint09/JSONParser.svg?branch=master)](https://travis-ci.org/lightsprint09/JSONParser)

#JSONParser in Swift
Typesave JSON parsing in Swift by using custom initializers

##Example
 Your JSON payload
```javascript
 { 
    "type": "ICE",
    "number": 102,
    "destination": "Berlin Hbf"
 }
```
 Your model type
```swift
 struct Train {
     let type: String
     let number: Int
     let destination: String
 }
```
 Extend the model type by implementing ```JSONParsable``` initializer
```swift 
 extension Train: JSONParsable {
     init(JSON: Dictionary<String, AnyObject>) throws {
         //Handle missing data
         guard let trainType = JSON["type"] as? String, let trainNumber = JSON["number"] as? Int, let trainDestination = JSON["destination"] as? String
         else {
            throw NSError(domain: "Domain Error", code: 0, userInfo: nil)
         }
         self.type = trainType
         self.number = trainNumber
         self.destination = trainDestination
     }
 }
 ```
 
 ```swift 
 let trainJSONData: NSData = //your json payload
 let parser: JSONParsing = JSONParser()
 
 do {
    let iceTrain: Train = try parser.parseObject(trainJSONData)
 } catch {
    //handle error
 }
```
