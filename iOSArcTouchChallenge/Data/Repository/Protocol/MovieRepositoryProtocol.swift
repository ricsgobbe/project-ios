//
//  MovieRepositoryProtocol.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation

protocol MovieRepositoryProtocol: MovieCacheRepositoryProtocol {
    
    var datasource: MovieDatasourceProtocol! {get set}
    
    func downloadConfigObj(completion: @escaping (Configuration?, Error?) -> Void)
    func downloadGenreList(completion: @escaping ([Genre]?, Error?) -> Void)
    func downloadUpcomingMovies(page: Int, completion: @escaping ([Movie]?, Error?) -> Void)
    func downloadMovieDetailsWith(id: Int, completion: @escaping (MovieDetail?, Error?) -> Void)
}
