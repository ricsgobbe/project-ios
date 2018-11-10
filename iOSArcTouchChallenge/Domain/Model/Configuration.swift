//
//  Configuration.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 09/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftyUserDefaults

struct Configuration: Codable, DefaultsSerializable {
    
    let changeKeys: [String]
    let image: Images
    
    init(json: JSON) {
        changeKeys = json["change_keys"].arrayValue.map({ $0.stringValue })
        let imageObj = Images(json: json["images"])
        image = imageObj
    }
    
}

struct Images: Codable, DefaultsSerializable {
    
    let baseUrl: String
    let secureBaseUrl: String
    let backdropSizes: [String]
    let logoSizes: [String]
    let posterSizes: [String]
    let profileSizes: [String]
    let stillSizes: [String]
    
    init(json: JSON) {
        baseUrl = json["base_url"].stringValue
        secureBaseUrl = json["secure_base_url"].stringValue
        backdropSizes = json["backdrop_sizes"].arrayValue.map({ $0.stringValue })
        logoSizes = json["logo_sizes"].arrayValue.map({ $0.stringValue })
        posterSizes = json["poster_sizes"].arrayValue.map({ $0.stringValue })
        profileSizes = json["profile_sizes"].arrayValue.map({ $0.stringValue })
        stillSizes = json["still_sizes"].arrayValue.map({ $0.stringValue })
    }
    
}
