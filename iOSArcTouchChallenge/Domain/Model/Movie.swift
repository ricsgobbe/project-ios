//
//  Movie.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 09/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie {
    
    let name: String
    let backdropImage: String
    let genres: [Int]
    let overview: String
    let releaseDate: String
    
    init(json: JSON) {
        name = json["name"].stringValue
        backdropImage = json["backdrop_image"].stringValue
        genres = json["genres"].arrayValue.map({ $0.intValue })
        overview = json["overview"].stringValue
        releaseDate = json["release_date"].stringValue
    }
    
    
}
