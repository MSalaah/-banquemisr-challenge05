//
//  ModuleFactory.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 31/01/2025.
//

import Foundation
import UIKit

/*
 This class is responsible for dependecy injection
 */
class ModuleFactory {
    let apiClient: APIProtocol
    let repo: MoviesRepoContract
    let useCase: MoviesListUseCaseProtocol
    
    static let shared = ModuleFactory()
    
    private init() {
        apiClient = ApiClient()
        repo = MoviesRepoImp(apiClient: apiClient)
        useCase =  MoviesListUseCase(repo: repo)
    }
    
    func createModule()-> MoviesListViewController {
        let viewController = MoviesListViewController()
        let viewModel = MoviesListViewModel(moviesListUseCase: useCase)
        viewController.viewmodel = viewModel
        return viewController
    }
    
    func createDetailsModule(nav: UINavigationController?, movieId: Int) {
        let viewController = MovieDetailsViewController()
        let useCase: MovieDetailsUseCaseProtocol = MovieDetailsUseCase(repo: repo)
        let viewModel = MovieDetailsViewModel(movieId: movieId, moviesDetailsUseCase: useCase)
        viewController.viewmodel = viewModel
        nav?.pushViewController(viewController, animated: true)
    }
}
