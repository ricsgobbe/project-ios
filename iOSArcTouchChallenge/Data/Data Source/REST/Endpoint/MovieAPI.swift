//
//  MovieApi.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 09/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation

import Moya

enum MovieAPI {
    case upcomingMovies(page: Int)
    case movieApiConfiguration()
    case getGenres()
    case getMovieDetail(movieId: Int)
    case search(movie: String)
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

extension MovieAPI: MovieTargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }

    var path: String {
        switch self {
        case .upcomingMovies(_):
            return "movie/upcoming"
        case .movieApiConfiguration(_):
            return "configuration"
        case .getGenres:
            return "genre/movie/list"
        case .getMovieDetail(let movieId):
            return "movie/\(movieId)"
        case .search(_):
            return "search/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .upcomingMovies(_):
            return .get
        case .movieApiConfiguration:
            return .get
        case .getGenres:
            return .get
        case .getMovieDetail(_):
            return .get
        case .search(_):
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .upcomingMovies(let page):
            return ["api_key": API_KEY, "page": page]
        case .search(let movie):
            return ["api_key": API_KEY, "query": movie]
        default: return ["api_key": API_KEY]
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }

    
}
