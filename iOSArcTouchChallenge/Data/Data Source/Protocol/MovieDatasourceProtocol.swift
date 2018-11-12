//
//  MovieDatasourceProtocol.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 09/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation

protocol MovieDatasourceProtocol {
    
    func getApiConfiguration(completion: @escaping (Configuration?, Error?) -> Void)
    func fetchGenreList(completion: @escaping ([Genre]?, Error?) -> Void)
    func fetchUpcomingMovie(page: Int, completion: @escaping (MovieResponse?, Error?) -> Void)
    func getMovieDetailsWith(id: Int, completion: @escaping (MovieDetail?, Error?) -> Void)
    func search(movie: String, completion: @escaping (MovieResponse?, Error?) -> Void)
}
