//: Playground - noun: a place where people can play

import UIKit
import JSONParser

let trainJSONData = "{\"type\": \"ICE\", \"number\": 102, \"destination\": \"Berlin Hbf\"}".data(using: String.Encoding.utf8)!

struct Train {
    let type: String
    let number: Int
    let destination: String
}

extension Train: JSONParsable {
    init(JSON: ThrowableDictionary) throws {
        //Handle missing data
        self.type = try JSON.valueFor(keyPath: "type")
        self.number = try JSON.valueFor(keyPath: "number")
        self.destination = try JSON.valueFor(keyPath: "destination")
    }
}

let parser: JSONParsing = JSONParser()

let iceTrain: Train = try! parser.parseObject(data: trainJSONData)


//Complex Example

let trainWithLocationJSONData = "{\"type\": \"ICE\", \"number\": 102, \"destination\": \"Berlin Hbf\", \"location\": {\"longitude\": 9.90280151, \"latitude\": 51.58730407}}".data(using: String.Encoding.utf8)!

struct Location {
    let longitude: Double
    let latitude: Double
}

extension Location: JSONParsable {
    init(JSON: ThrowableDictionary) throws {
        self.latitude = try JSON.valueFor(keyPath: "latitude")
        self.longitude = try JSON.valueFor(keyPath: "latitude")
    }
}

struct TrainWithLocation {
    let type: String
    let number: Int
    let destination: String
    let location: Location
}

extension TrainWithLocation: JSONParsable {
    init(JSON: ThrowableDictionary) throws {
        self.type = try JSON.valueFor(keyPath: "type")
        self.number = try JSON.valueFor(keyPath: "number")
        self.destination = try JSON.valueFor(keyPath: "destination")
        self.location = try JSON.valueFor(keyPath: "location")
    }
}

let iceTrainWithLocation: TrainWithLocation = try! parser.parseObject(data: trainWithLocationJSONData)

