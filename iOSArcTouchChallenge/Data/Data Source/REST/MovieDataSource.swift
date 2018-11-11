//
//  MovieDataSource.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 09/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation
import Moya

class MovieDataSource: MovieDatasourceProtocol {
    
    func getApiConfiguration(completion: @escaping (Configuration?, Error?) -> Void) {
        let service = getApiService()
        service.request(.movieApiConfiguration()) { (result) in
            switch result {
            case .success(let json):
                let configuration = Configuration(json: json)
                completion(configuration, nil)
                return
            case .failure(let error):
                completion(nil, error)
                return
            }
        }
    }
    
    func fetchGenreList(completion: @escaping ([Genre]?, Error?) -> Void) {
        let service = getApiService()
        service.request(.getGenres()) { (result) in
            switch result {
            case .success(let genreJson):
                let genreList = genreJson["genres"].arrayValue.map({ Genre(json: $0) })
                completion(genreList, nil)
                return
            case .failure(let error):
                completion(nil, error)
                return
            }
        }
    }
    
    func fetchUpcomingMovie(page: Int, completion: @escaping (MovieResponse?, Error?) -> Void) {
        let service = getApiService()
        service.request(.upcomingMovies(page: page)) { (result) in
            switch result {
            case .success(let moviesJson):
                let result = MovieResponse(json: moviesJson)
                completion(result, nil)
                return
            case .failure(let error):
                completion(nil, error)
                return
            }
        }
        
    }
    
    func getMovieDetailsWith(id: Int, completion: @escaping (MovieDetail?, Error?) -> Void) {
        let service = getApiService()
        service.request(.getMovieDetail(movieId: id)) { (result) in
            switch result {
            case .success(let movieDetailJson):
                let movieDetails = MovieDetail(json: movieDetailJson)
                completion(movieDetails, nil)
                return
            case .failure(let error):
                completion(nil, error)
                return
            }
        }
    }
    
    fileprivate func getApiService() -> Service<MovieAPI> {
        return Service<MovieAPI>(plugins: [MoviePlugins()])
    }
    
}
