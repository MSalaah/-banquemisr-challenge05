//
//  MoviesListViewModel.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 31/01/2025.
//

import Foundation

protocol MoviesListViewModelProtocol: ViewProtocol {
    func didSelectTab(type: MovieType)
    func didSelectMovie(index: IndexPath)
    var  moviesList: [Movie] { get set }
    var  onListFetched: (() -> Void)? {get set}
}

class MoviesListViewModel: MoviesListViewModelProtocol {
    var onListFetched: (() -> Void)?
    
    var moviesList: [Movie] = []
    
    
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var onError: (() -> Void)?
    
    //initial Tab
    private var selectedType: MovieType = .nowPlaying
    
    private var moviesListUseCase: MoviesListUseCaseProtocol
    init(moviesListUseCase: MoviesListUseCaseProtocol) {
        self.moviesListUseCase = moviesListUseCase
    }
    
    func didSelectTab(type: MovieType) {
        //Change Current Selected Tab Value and execute the usecase
        selectedType = type
        fetchList()
    }
    
    func didSelectMovie(index: IndexPath) {
        // Navigate to details screen
        let movie = moviesList[index.row]

    }
    
    private func fetchList() {
        showLoading?()
        moviesListUseCase.fetchMovies(type: selectedType) { [weak self] result in
            guard let self = self else {return}
            self.hideLoading?()
            switch result {
            case .success(let response):
                moviesList = response?.results ?? []
                onListFetched?()
            case .failure (let error):
                print(error)
                self.onError?()
            }
        }
    }
}
