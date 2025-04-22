//
//  RatedThing.swift
//  ThingRater
//
//  Created by Russell Mirabelli on 6/27/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import UIKit

class RatedThing: Codable {
    var name: String
    private var _rating: Int = 0
    var rating: Int {
        set {
            let nv = (newValue < 0 ? 0 : (newValue > 5 ? 5 : newValue))
            _rating = nv
        }
        get {
            return _rating
        }
    }
    var image: UIImage?

    func getNameBackwards() -> String {
        return String(name.reversed())
    }

    init(name: String, rating: Int, image: UIImage?) {
        self.name = name
        self.image = image
        self.rating = rating
    }

    enum CodingKeys: String, CodingKey {
        case name, rating, image
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Int.self, forKey: .rating)
        if let imageData = try container.decodeIfPresent(Data.self, forKey: .image) {
            image = UIImage(data: imageData)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(rating, forKey: .rating)
        try container.encodeIfPresent(image?.pngData(), forKey: .image)
    }

}
