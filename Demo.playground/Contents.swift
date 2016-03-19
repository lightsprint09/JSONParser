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

