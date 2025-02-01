//
//  MoviesListUseCase.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 29/01/2025.
//

protocol MoviesListUseCaseProtocol {
    func fetchMovies(type: MovieType, completion: ((Result<ListResponse?, NetworkError>) -> Void)?)
}

class MoviesListUseCase: MoviesListUseCaseProtocol {
    
    private let repo: MoviesRepoContract
    
    init(repo: MoviesRepoContract) {
        self.repo = repo
    }
    
    func fetchMovies(type: MovieType, completion: ((Result<ListResponse?, NetworkError>) -> Void)?) {
        repo.fetchMovies(type: type) { result in
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
