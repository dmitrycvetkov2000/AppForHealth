//
//  MoreInfoAboutReceipt.swift
//  AppForHealth
//
//  Created by Дмитрий Цветков on 16.05.2023.
//

import Foundation

// MARK: - MoreInfoAboutReceipt
struct MoreInfoAboutReceipt: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool?
    let veryHealthy, cheap, veryPopular, sustainable: Bool?
    let lowFodmap: Bool?
    let weightWatcherSmartPoints: Int?
    let gaps: String?
    let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int?
    let creditsText, sourceName: String?
    let pricePerServing: Double?
    let extendedIngredients: [ExtendedIngredient]?
    let id: Int?
    let title: String?
    let readyInMinutes, servings: Int?
    let sourceURL: String?
    let image: String?
    let imageType: String?
    let nutrition: Nutrition?
    let summary: String?
    fileprivate let cuisines: [JSONAny]?
    let dishTypes, diets, occasions: [String]?
    let winePairing: WinePairing?
    let instructions: String?
    let analyzedInstructions: [AnalyzedInstruction]?
    fileprivate let originalID: JSONNull?
    let spoonacularSourceURL: String?

    enum CodingKeys: String, CodingKey {
        case vegetarian, vegan, glutenFree, dairyFree, veryHealthy, cheap, veryPopular, sustainable, lowFodmap, weightWatcherSmartPoints, gaps, preparationMinutes, cookingMinutes, aggregateLikes, healthScore, creditsText, sourceName, pricePerServing, extendedIngredients, id, title, readyInMinutes, servings
        case sourceURL = "sourceUrl"
        case image, imageType, nutrition, summary, cuisines, dishTypes, diets, occasions, winePairing, instructions, analyzedInstructions
        case originalID = "originalId"
        case spoonacularSourceURL = "spoonacularSourceUrl"
    }
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable {
    let name: String?
    let steps: [Step]?
}

// MARK: - Step
struct Step: Codable {
    let number: Int?
    let step: String?
    let ingredients, equipment: [Ent]?
    let length: Length?
}

// MARK: - Ent
struct Ent: Codable {
    let id: Int?
    let name, localizedName, image: String?
}

// MARK: - Length
struct Length: Codable {
    let number: Int?
    let unit: String?
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable {
    let id: Int?
    let aisle, image: String?
    let consistency: Consistency?
    let name, nameClean, original, originalName: String?
    let amount: Double?
    let unit: String?
    let meta: [String]?
    let measures: Measures?
}

enum Consistency: String, Codable {
    case liquid = "LIQUID"
    case solid = "SOLID"
}

// MARK: - Measures
struct Measures: Codable {
    let us, metric: Metric?
}

// MARK: - Metric
struct Metric: Codable {
    let amount: Double?
    let unitShort, unitLong: String?
}

// MARK: - Nutrition
struct Nutrition: Codable {
    let nutrients, properties, flavonoids: [Flavonoid]?
    let ingredients: [Ingredient]?
    let caloricBreakdown: CaloricBreakdown?
    let weightPerServing: WeightPerServing?
}

// MARK: - CaloricBreakdown
struct CaloricBreakdown: Codable {
    let percentProtein, percentFat, percentCarbs: Double?
}

// MARK: - Flavonoid
struct Flavonoid: Codable {
    let name: String?
    let amount: Double?
    let unit: Unit?
    let percentOfDailyNeeds: Double?
}

enum Unit: String, Codable {
    case empty = ""
    case g = "g"
    case iu = "IU"
    case kcal = "kcal"
    case mg = "mg"
    case unit = "%"
    case вµg = "Вµg"
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let id: Int?
    let name: String?
    let amount: Double?
    let unit: String?
    let nutrients: [Flavonoid]?
}

// MARK: - WeightPerServing
struct WeightPerServing: Codable {
    let amount: Int?
    let unit: Unit?
}

// MARK: - WinePairing
struct WinePairing: Codable {
    fileprivate let pairedWines: [JSONAny]?
    let pairingText: String?
    fileprivate let productMatches: [JSONAny]?
}

// MARK: - Encode/decode helpers

fileprivate class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

fileprivate class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

fileprivate class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}