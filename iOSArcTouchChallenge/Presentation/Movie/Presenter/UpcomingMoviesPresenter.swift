//
//  UpcomingMoviesPresenter.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation

protocol UpcomingMovieProtocol {
    var useCase: MovieUseCases! {get set}
    
    func downloadGenresList()
    func downloadConfigObj()
    func fetchMovies()
    func loadMoreMovies()
    func showMovieDetail(id: Int)
    func getConfig() -> Configuration?
    func getMovieGenre(ids: [Int]) -> [Genre]?
}

class UpcomingMoviesPresenter: UpcomingMovieProtocol {
    
    var useCase: MovieUseCases!
    var movieResult: MovieResponse?
    
    init() {
        useCase = MovieUseCases()
    }
    
    func downloadGenresList() {
        useCase.downloadGenreList()
    }
    
    func downloadConfigObj() {
        useCase.downloadConfiguratorObj()
    }
    
    func fetchMovies() {
        useCase.displayUpcomingMovies { [weak self](result, error) in
            self?.movieResult = result
        }
    }
    
    func loadMoreMovies() {
        guard let result = movieResult else {
            return
        }
        useCase.displayUpcomingMovies(page: result.page) { [weak self](result, error) in
            self?.movieResult = result
        }
    }
    
    func showMovieDetail(id: Int) {
        useCase.displayMovieDetail(id: id) { (movieDetail, error) in
            
        }
    }
    
    func getConfig() -> Configuration? {
        return useCase.getConfig()
    }
    
    func getMovieGenre(ids: [Int]) -> [Genre]? {
        guard let genres = useCase.getGenreList() else {
            return nil
        }
        let result = genres.filter { (genre) -> Bool in
            return ids.contains(genre.id)
        }
        return result
    }
    
}
