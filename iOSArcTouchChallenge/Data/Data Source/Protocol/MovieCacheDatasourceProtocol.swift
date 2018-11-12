//
//  MovieCacheDatasourceProtocol.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation


protocol MovieCacheDatasourceProtocol {
    
    func saveConfiguration(config: Configuration)
    func retrieveConfiguration() -> Configuration?
    func saveGenreList(genreList: [Genre])
    func retrieveGenreList() -> [Genre]?
}
