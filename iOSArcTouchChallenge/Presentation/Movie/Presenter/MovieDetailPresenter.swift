//
//  MovieDetailPresenter.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 11/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import UIKit

protocol MovieDetailPresenterProtocol: class {
    var view: MovieDetailTableViewProtocol! {get set}
    var movieUseCase: MovieUseCases! {get set}
    
    func getMovieDetail(id: Int)
    func getConfig() -> Configuration?
    
    
}


class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var view: MovieDetailTableViewProtocol!
    var movieUseCase: MovieUseCases!
    
    init(view: MovieDetailTableViewProtocol) {
        self.view = view
        movieUseCase = MovieUseCases()
    }
    
    func getMovieDetail(id: Int) {
        movieUseCase.displayMovieDetail(id: id) { [weak self] (details, error) in
            self?.displayingValues(details: details, error: error)
        }
    }
    
    func getConfig() -> Configuration? {
        return movieUseCase.getConfig()
    }
    
    fileprivate func displayingValues(details: MovieDetail?, error: Error?) {
        if error == nil {
            if let movieDetails = details {
                self.view.stopLoading()
                
                self.view.displayDetails(detail: movieDetails)
            } else {
                self.view.showError(message: "No item was found.")
            }
        } else {
            self.view.showMsg(message: .error)
            self.view.showError(message: "Something unexpected happened.")
        }
    }
    
    fileprivate func isConnectedToInternet() {
        if !NetworkManager.isConnectedToInternet(controller: view as! UIViewController) {
            return
        }
    }
}

