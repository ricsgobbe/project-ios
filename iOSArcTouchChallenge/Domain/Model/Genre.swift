//
//  Genre.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 09/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Genre {
    
    let id: Int
    let name: String
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
    }
    
    
}
