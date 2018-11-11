//
//  MovieUseCases.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation

class MovieUseCases {
    
    var repository: MovieRepositoryProtocol!
    var cacheRepository: MovieCacheRepositoryProtocol!
    
    init() {
        repository = MovieRepository()
        repository.datasource = MovieDataSource()
        cacheRepository = MovieCacheRepository()
        cacheRepository.cacheDatasource = MovieCacheDatasource()
    }
    
    func displayUpcomingMovies(page : Int = 1, completion: @escaping (MovieResponse?, Error?) -> Void) {
        repository.downloadUpcomingMovies(page: page, completion: completion)
    }
    
    func displayMovieDetail(id: Int, completion: @escaping (MovieDetail?, Error?) -> Void) {
        repository.downloadMovieDetailsWith(id: id, completion: completion)
    }
    
    func downloadConfiguratorObj() {
        repository.downloadConfigObj { [weak self] (config, error) in
            guard let configurator = config else {
                return
            }
            self?.cacheRepository.save(configObj: configurator)
        }
    }
    
    func downloadGenreList() {
        repository.downloadGenreList { [weak self] (genres, error) in
            guard let genresList = genres else {
                return
            }
            self?.cacheRepository.save(genreList: genresList)
        }
    }
    
    func getGenreList() -> [Genre]? {
        return cacheRepository.retrieveGenreList()
    }
    
    func getConfig() -> Configuration? {
        return cacheRepository.retrieveConfigObj()
    }
    
}
