//
//  MovieCacheDatasource.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class MovieCacheDatasource {
    let configurationKey = DefaultsKey<Configuration?>("configuration_key")
    let genreKey = DefaultsKey<[Genre]?>("genre_list_key")
    
    func saveConfiguration(config: Configuration) {
        Defaults[configurationKey] = config
    }
    
    func retrieveConfiguration() -> Configuration? {
        return Defaults[configurationKey] ?? nil
    }
    
    func saveGenreList(genreList: [Genre]) {
        Defaults[genreKey] = genreList
    }
    
    func retrieveGenreList() -> [Genre]? {
        return Defaults[genreKey]
    }
}
