//
//  MoviesListViewModel.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 31/01/2025.
//

protocol MoviesListViewModelProtocol {
    func didSelectTab(type: MovieType)
    func didSelectMovie()
    var  onError: (() -> Void)? { get set }
    var  showLoading: (() -> Void)? { get set }
    var  hideLoading: (() -> Void)? { get set }
}

class MoviesListViewModel: MoviesListViewModelProtocol {
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
    
    func didSelectMovie() {
        //Navigate to details screen
    }
    
    private func fetchList() {
        showLoading?()
        moviesListUseCase.fetchMovies(type: selectedType) { [weak self] result in
            guard let self = self else {return}
            self.hideLoading?()
            switch result {
            case .success(let response):
                print(response?.results.count)
            case .failure:
                self.onError?()
            }
        }
    }
}
