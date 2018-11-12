//
//  UpcomingMoviesPresenter.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import Foundation

protocol UpcomingMovieProtocol: class {
    var view: UpcomingMoviesView! {get set}
    var useCase: MovieUseCases! {get set}
    var upcomingMovie: [Movie]! {get set}
    
    func downloadGenresList()
    func downloadConfigObj()
    func fetchMovies()
    func loadMoreMovies()
    func getConfig() -> Configuration?
    func getMovieGenre(ids: [Int]) -> [Genre]
    func getMovieAt(position: Int) -> Movie?
    func movieListSize() -> Int
    func search(movie: String)
}

class UpcomingMoviesPresenter: UpcomingMovieProtocol {
    
    var useCase: MovieUseCases!
    weak var view: UpcomingMoviesView!
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
            self?.upcomingMovie.removeAll()
            self?.showMovies(result: result)
        }
    }
    
    func fetchMovies() {
        useCase.displayUpcomingMovies { [weak self](result, error) in
            self?.upcomingMovie.removeAll()
            self?.showMovies(result: result)
        }
    }
    
    func loadMoreMovies() {
        guard let result = movieResult else {
            return
        }
        let nextPage = result.page + 1
        useCase.displayUpcomingMovies(page: nextPage) { [weak self](result, error) in
            self?.showMovies(result: result)
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
    
    fileprivate func showMovies(result: MovieResponse?) {
        movieResult = result
        populateUpcomingMovie(response: result)
        if upcomingMovie.isEmpty {
            view.showMsg(message: .warning)
        } else {
            view.showMovieList()
        }
    }
    
    fileprivate func isConnectedToInternet() {
        if !NetworkManager.isConnectedToInternet(controller: view) {
            return
        }
    }
    
    fileprivate func populateUpcomingMovie(response: MovieResponse?) {
        guard let movies = response?.movies else {
            return
        }
        upcomingMovie.append(contentsOf: movies)
    }
    
}
