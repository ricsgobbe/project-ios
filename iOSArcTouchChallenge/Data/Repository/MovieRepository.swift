//
//  MovieRepository.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation

class MovieRepository: MovieRepositoryProtocol {
    var datasource: MovieDatasourceProtocol!
    
    func downloadConfigObj(completion: @escaping (Configuration?, Error?) -> Void) {
        datasource.getApiConfiguration(completion: completion)
    }
    
    func downloadGenreList(completion: @escaping ([Genre]?, Error?) -> Void) {
        datasource.fetchGenreList(completion: completion)
    }
    
    func downloadUpcomingMovies(page: Int, completion: @escaping (MovieResponse?, Error?) -> Void) {
        datasource.fetchUpcomingMovie(page: page, completion: completion)
    }
    
    func downloadMovieDetailsWith(id: Int, completion: @escaping (MovieDetail?, Error?) -> Void) {
        datasource.getMovieDetailsWith(id: id, completion: completion)
    }
    
}
