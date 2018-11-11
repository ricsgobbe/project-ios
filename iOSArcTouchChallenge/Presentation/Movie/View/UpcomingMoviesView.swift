//
//  UpcomingMoviesView.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 11/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import UIKit
import Reusable

protocol UpcomingMoviesViewProtocol: class, LoadingView {
    var presenter: UpcomingMovieProtocol! {get set}
    
    func showMovieList(movies: [Movie])
    func showMsg(message: AlertTypes)
}


class UpcomingMoviesView: UIViewController, StoryboardBased {
    
    var presenter: UpcomingMovieProtocol!
    var tapGesture: UITapGestureRecognizer!
    var refreshControl: UIRefreshControl!

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var movieDetailTableView: UITableView!
    
    override func viewDidLoad() {
        initialSetup()
    }
    
    fileprivate func initialSetup() {
        tableViewSetup()
        presenter = UpcomingMoviesPresenter(view: self)
        presenter.fetchMovies()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        loadingView.addGestureRecognizer(tapGesture)
        loadingView.isUserInteractionEnabled = true
    }
    
    fileprivate func tableViewSetup() {
        movieDetailTableView.register(cellType: MovieListTableViewCell.self)
        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self
        movieDetailTableView.estimatedRowHeight = MovieListTableViewCell.height
        movieDetailTableView.rowHeight = UITableView.automaticDimension
    }
    
    
}

extension UpcomingMoviesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as MovieListTableViewCell
        guard let movie = presenter.getMovieAt(position: indexPath.row) else {
            fatalError()
        }
        cell.imageDownloadSetup(config: presenter.getConfig(), backdropPath: movie.backdropImage)
        cell.render(movie: movie)
        let genres = presenter.getMovieGenre(ids: movie.genres)
        cell.setMovieGenres(genresList: genres)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movieListSize()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieListTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
}


extension UpcomingMoviesView: UpcomingMoviesViewProtocol {
    
    func showError(message: String) {
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer?) {
        
    }
    
    
    func showMovieList(movies: [Movie]) {
        self.movieDetailTableView.reloadData()
    }
    
    func showMsg(message: AlertTypes) {
        
    }
    
    
}
