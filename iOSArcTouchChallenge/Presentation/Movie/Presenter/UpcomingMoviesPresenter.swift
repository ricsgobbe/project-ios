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
    var upcomingMovie: [Movie]! {get set}
    
    func downloadGenresList()
    func downloadConfigObj()
    func fetchMovies()
    func loadMoreMovies()
    func showMovieDetail(id: Int)
    func getConfig() -> Configuration?
    func getMovieGenre(ids: [Int]) -> [Genre]
    func getMovieAt(position: Int) -> Movie?
    func movieListSize() -> Int
    func search(movie: String)
}

class UpcomingMoviesPresenter: UpcomingMovieProtocol {
    
    var useCase: MovieUseCases!
    var view: UpcomingMoviesView!
    var upcomingMovie: [Movie]!
    var movieResult: MovieResponse?
    
    init(view: UpcomingMoviesView) {
        useCase = MovieUseCases()
        upcomingMovie = [Movie]()
        self.view = view
    }
    
    func downloadGenresList() {
        useCase.downloadGenreList()
    }
    
    func downloadConfigObj() {
        useCase.downloadConfiguratorObj()
    }
    
    func search(movie: String) {
        useCase.searchMovie(name: movie) { [weak self] (result, error) in
            self?.movieResult = result
            self?.upcomingMovie.removeAll()
            self?.populateUpcomingMovie(response: result)
            self?.view.showMovieList(movies: [])
        }
    }
    
    func fetchMovies() {
        useCase.displayUpcomingMovies { [weak self](result, error) in
            self?.movieResult = result
            self?.upcomingMovie.removeAll()
            self?.populateUpcomingMovie(response: result)
            self?.view.showMovieList(movies: [])
        }
    }
    
    func loadMoreMovies() {
        guard let result = movieResult else {
            return
        }
        useCase.displayUpcomingMovies(page: result.page + 1) { [weak self](result, error) in
            self?.movieResult = result
            self?.populateUpcomingMovie(response: result)
            self?.view.showMovieList(movies: [])
        }
    }
    
    func showMovieDetail(id: Int) {
        useCase.displayMovieDetail(id: id) { (movieDetail, error) in
            
        }
    }
    
    func getMovieAt(position: Int) -> Movie? {
        let movie: Movie = upcomingMovie[position]
        return movie
    }
    func movieListSize() -> Int {
        let movies: [Movie] = upcomingMovie
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
    
    fileprivate func populateUpcomingMovie(response: MovieResponse?) {
        guard let movies = response?.movies else {
            return
        }
        upcomingMovie.append(contentsOf: movies)
    }
    
}
