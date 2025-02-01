//
//  MovieDetailsViewModel.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 31/01/2025.
//

protocol MovieDetailsViewModelProtocol: ViewProtocol {
    var onResponse: ((MovieDetailsResponse) -> Void)? {get set}
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    var onError: (() -> Void)?
    
    var showLoading: (() -> Void)?
    
    var hideLoading: (() -> Void)?
    
    var onResponse: ((MovieDetailsResponse) -> Void)?
    
    private var moviesDetailsUseCase: MovieDetailsUseCaseProtocol
    private var movieId: Int
    
    init(movieId: Int, moviesDetailsUseCase: MovieDetailsUseCaseProtocol) {
        self.movieId = movieId
        self.moviesDetailsUseCase = moviesDetailsUseCase
        fetchDetails()
    }
    
    private func fetchDetails() {
        showLoading?()
        moviesDetailsUseCase.fetchMovieDetails(movieId: movieId) { [weak self] result in
            guard let self = self else {return}
            self.hideLoading?()
            switch result {
            case .success(let response):
                onResponse?(response)
            case .failure (let error):
                print(error)
                self.onError?()
            }
        }
    }
}
