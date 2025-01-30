//
//  MovieDetailsUseCase.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 30/01/2025.
//

protocol MovieDetailsUseCaseProtocol {
    func fetchMovieDetails(movieId: Int, completion: ((Result<MovieDetailsResponse?, NetworkError>) -> Void)?)

}

class MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    
    private let repo: MoviesRepoContract
    
    init(repo: MoviesRepoContract) {
        self.repo = repo
    }
    
    func fetchMovieDetails(movieId: Int, completion: ((Result<MovieDetailsResponse?, NetworkError>) -> Void)?) {
        
    }
}
