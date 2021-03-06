//
//  MovieRepositoryProtocol.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation

protocol MovieRepositoryProtocol: class {
    
    var datasource: MovieDatasourceProtocol! {get set}
    
    func downloadConfigObj(completion: @escaping (Configuration?, Error?) -> Void)
    func downloadGenreList(completion: @escaping ([Genre]?, Error?) -> Void)
    func downloadUpcomingMovies(page: Int, completion: @escaping (MovieResponse?, Error?) -> Void)
    func downloadMovieDetailsWith(id: Int, completion: @escaping (MovieDetail?, Error?) -> Void)
    func searchMovieWith(name: String, completion: @escaping (MovieResponse?, Error?) -> Void)
}
