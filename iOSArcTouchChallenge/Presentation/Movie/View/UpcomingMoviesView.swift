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
    var coordinator: Coordinator! {get set}
    var presenter: UpcomingMovieProtocol! {get set}
    
    func showMovieList(movies: [Movie])
    func showMsg(message: AlertTypes)
}


class UpcomingMoviesView: UIViewController, StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = UIStoryboard(name: "UpcomingMoviesView", bundle: nil)
    
    
    var coordinator: Coordinator!
    var presenter: UpcomingMovieProtocol!
    var tapGesture: UITapGestureRecognizer!
    var refreshControl: UIRefreshControl!
    

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var movieDetailTableView: UITableView!
    
    override func viewDidLoad() {
        initialSetup()
    }
    
    fileprivate func initialSetup() {
        presenter = UpcomingMoviesPresenter(view: self)
        startLoading()
        tableViewSetup()
        pullToRefreshSetup()
        setupBottomIndicatorView()
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
    
    fileprivate func pullToRefreshSetup() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = ColorPalette.mainColor
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        movieDetailTableView.addSubview(refreshControl)
    }
    
    fileprivate func endSwipePull(){
        if refreshControl != nil {
            self.refreshControl.endRefreshing()
        }
    }
    
    fileprivate func stopBottomIndicator() {
        self.movieDetailTableView.tableFooterView?.isHidden = true
    }
    
    fileprivate func startBottomIndicator() {
        self.movieDetailTableView.tableFooterView?.isHidden = false
    }
    
    fileprivate func setupBottomIndicatorView() {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: movieDetailTableView.bounds.width, height: CGFloat(44))
        
        self.movieDetailTableView.tableFooterView = spinner
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
       let selectedMovie = presenter.getMovieAt(position: indexPath.row)
        guard let id = selectedMovie?.id else {
            return
        }
       coordinator.showMovieDetails(id: id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            startBottomIndicator()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 {
            presenter.loadMoreMovies()
        }
    }
    
}


extension UpcomingMoviesView: UpcomingMoviesViewProtocol {
    
    func showError(message: String) {
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer?) {
        presenter.fetchMovies()
    }
    
    @objc func refresh(_ sender: Any) {
        presenter.fetchMovies()
    }
    
    func showMovieList(movies: [Movie]) {
        self.movieDetailTableView.reloadData()
        stopLoading()
        endSwipePull()
        stopBottomIndicator()
    }
    
    func showMsg(message: AlertTypes) {
        AlertManager.createOneButtonAlert(controller: self, type: message)
        endSwipePull()
    }
    
    
}
