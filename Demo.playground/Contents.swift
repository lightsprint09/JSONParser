//: Playground - noun: a place where people can play

import UIKit
import JSONParser

let trainJSONData = "{\"type\": \"ICE\", \"number\": 102, \"destination\": \"Berlin Hbf\"}".dataUsingEncoding(NSUTF8StringEncoding)!

struct Train {
    let type: String
    let number: Int
    let destination: String
}

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

let parser: JSONParsing = JSONParser()

let iceTrain: Train = try! parser.parseObject(trainJSONData)


//Complex Example

let trainWithLocationJSONData = "{\"type\": \"ICE\", \"number\": 102, \"destination\": \"Berlin Hbf\", \"location\": {\"longitude\": 9.90280151, \"latitude\": 51.58730407}}".dataUsingEncoding(NSUTF8StringEncoding)!

struct Location {
    let longitude: Double
    let latitude: Double
}

extension Location: JSONParsable {
    init(JSON: Dictionary<String, AnyObject>) {
        self.latitude = JSON["latitude"] as! Double
        self.longitude = JSON["longitude"] as! Double
    }
}

struct TrainWithLocation {
    let type: String
    let number: Int
    let destination: String
    let location: Location
}

extension TrainWithLocation: JSONParsable {
    init(JSON: Dictionary<String, AnyObject>) throws {
        //Handle missing data
        guard let trainType = JSON["type"] as? String, let trainNumber = JSON["number"] as? Int, let trainDestination = JSON["destination"] as? String, let trainLocation = JSON.transformToObject(keyPath: "location") as Location?
            else {
                throw NSError(domain: "Domain Error", code: 0, userInfo: nil)
        }
        self.type = trainType
        self.number = trainNumber
        self.destination = trainDestination
        self.location = trainLocation
    }
}

let iceTrainWithLocation: TrainWithLocation = try! parser.parseObject(trainWithLocationJSONData)

