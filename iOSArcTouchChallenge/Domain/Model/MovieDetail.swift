//
//  MovieDetail.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 09/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieDetail {
    
    let name: String
    let posterImage: String
    let genre: [Genre]
    let overview: String
    let releaseDate: String
    
    init(json: JSON) {
        name = json["name"].stringValue
        posterImage = json["poster_image"].stringValue
        genre = json["genre"].arrayValue.map({ Genre(json: $0) })
        overview = json["overview"].stringValue
        releaseDate = json["release_date"].stringValue
    }
    
}
