//
//  MovieCacheRepositoryProtocol.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation

protocol MovieCacheRepositoryProtocol {
    
    var cacheDatasource: MovieCacheDatasourceProtocol! {get set}
    
    func save(configObj: Configuration)
    func retrieveConfigObj() -> Configuration?
    func save(genreList: [Genre])
    func retrieveGenreList() -> [Genre]?
    
}
