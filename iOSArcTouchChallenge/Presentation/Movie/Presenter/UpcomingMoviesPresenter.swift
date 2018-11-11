//
//  UpcomingMoviesPresenter.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation

protocol UpcomingMovieProtocol {
    var view: UpcomingMoviesView! {get set}
    var useCase: MovieUseCases! {get set}
    
    func downloadGenresList()
    func downloadConfigObj()
    func fetchMovies()
    func loadMoreMovies()
    func showMovieDetail(id: Int)
    func getConfig() -> Configuration?
    func getMovieGenre(ids: [Int]) -> [Genre]
    func getMovieAt(position: Int) -> Movie?
    func movieListSize() -> Int
}

class UpcomingMoviesPresenter: UpcomingMovieProtocol {
    
    var useCase: MovieUseCases!
    var view: UpcomingMoviesView!
    var movieResult: MovieResponse?
    
    init(view: UpcomingMoviesView) {
        useCase = MovieUseCases()
        self.view = view
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
            self?.view.showMovieList(movies: [])
        }
    }
    
    func loadMoreMovies() {
        guard let result = movieResult else {
            return
        }
        useCase.displayUpcomingMovies(page: result.page) { [weak self](result, error) in
            self?.movieResult = result
            self?.view.showMovieList(movies: [])
        }
    }
    
    func showMovieDetail(id: Int) {
        useCase.displayMovieDetail(id: id) { (movieDetail, error) in
            
        }
    }
    
    func getMovieAt(position: Int) -> Movie? {
        guard let movie = movieResult?.movies[position] else {
            return nil
        }
        return movie
    }
    func movieListSize() -> Int {
        guard let movies = movieResult?.movies else {
            return 0
        }
        return movies.count
    }
    
    func getConfig() -> Configuration? {
        return useCase.getConfig()
    }
    
    func getMovieGenre(ids: [Int]) -> [Genre] {
        guard let genres = useCase.getGenreList() else {
            return []
        }
        let result = genres.filter { (genre) -> Bool in
            return ids.contains(genre.id)
        }        
        return result
    }
    
}
