//
//  MovieDetailsUseCase.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 30/01/2025.
//

protocol MovieDetailsUseCaseProtocol {
    func fetchMovieDetails(movieId: Int, completion: ((Result<MovieDetailsResponse, NetworkError>) -> Void)?)
}

class MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    
    private let repo: MoviesRepoContract
    
    init(repo: MoviesRepoContract) {
        self.repo = repo
    }
    
    func fetchMovieDetails(movieId: Int, completion: ((Result<MovieDetailsResponse, NetworkError>) -> Void)?) {
        repo.fetchMovieDetails(movieId: movieId) { result in
            switch result {
            case .success(let response):
                if let data = response {
                    completion?(.success(data))
                }
            case .failure(let error):
                print(error)
                completion?(.failure(.unknownError))
            }
        }
    }
}
