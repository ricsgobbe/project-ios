//
//  MainCoordinator.swift
//  iOSArcTouchChallenge
//
//  Created by Mac on 11/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: CustomNavigationBar { get set }
    
    func start()
    func showMovieDetails(id: Int)
}

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: CustomNavigationBar
    
    init(navigationController: CustomNavigationBar) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = UpcomingMoviesView.instantiate()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: false)
    }
    
    func showMovieDetails(id: Int) {
        let controller = MovieDetailTableView.instantiate()
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
        controller.getMovieDetail(id: id)
    }
    
    
}
