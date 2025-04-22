//
//  RatedThingCell.swift
//  ThingRater
//
//  Created by Amber  Pan on 6/28/19.
//  Copyright © 2019 Bottle Rocket Studios. All rights reserved.
//

import UIKit

class RatedThingCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var picture: UIImageView!
    
    func configure(thing: RatedThing){
        name.text = thing.name
        rating.text = "\(thing.rating) stars"
        picture.image = thing.image
    }
}
