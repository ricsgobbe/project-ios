//
//  MovieCacheRepository.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation

class MovieCacheRepository: MovieCacheRepositoryProtocol {
    
    var cacheDatasource: MovieCacheDatasourceProtocol!
    
    func save(configObj: Configuration) {
        cacheDatasource.saveConfiguration(config: configObj)
    }
    
    func retrieveConfigObj() -> Configuration? {
        return cacheDatasource.retrieveConfiguration()
    }
    
    func save(genreList: [Genre]) {
        cacheDatasource.saveGenreList(genreList: genreList)
    }
    
    func retrieveGenreList() -> [Genre]? {
        return cacheDatasource.retrieveGenreList()
    }
    
    
    
    
}
