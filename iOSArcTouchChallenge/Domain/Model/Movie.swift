//
//  Movie.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 09/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation
import SwiftyJSON



struct MovieResponse {
    let movies: [Movie]
    let page: Int
    let dates: [String]
    let totalPages: Int
    let totalResults: Int
    
    init(json: JSON) {
        movies = json["results"].arrayValue.map({ Movie(json: $0) })
        page = json["page"].intValue
        dates = json["dates"].arrayValue.map({ $0.stringValue })
        totalPages = json["total_pages"].intValue
        totalResults = json["total_results"].intValue
    }
}


struct Movie {
    
    let id: Int
    let name: String
    let backdropImage: String
    let genres: [Int]
    let overview: String
    let releaseDate: String
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["title"].stringValue
        backdropImage = json["backdrop_path"].stringValue
        genres = json["genre_ids"].arrayValue.map({ $0.intValue })
        overview = json["overview"].stringValue
        releaseDate = json["release_date"].stringValue

    }
    
    
}
