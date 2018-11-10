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
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

extension MovieAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://192.168.15.15")!
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
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    
    var headers: [String : String]? {
        switch self {
           default: return ["api_key": "1f54bd990f1cdfb230adb312546d765d"]
        }
    }
    
    
}
