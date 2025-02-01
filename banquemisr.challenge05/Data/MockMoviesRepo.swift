//
//  MockMoviesRepo.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 01/02/2025.
//

final class MockMoviesRepo: MoviesRepoContract {
    
    func fetchMovies(type: banquemisr_challenge05.MovieType, completion: ((Result<banquemisr_challenge05.ListResponse?, banquemisr_challenge05.NetworkError>) -> Void)?) {
        
    }
    
    func fetchMovieDetails(movieId: Int, completion: ((Result<banquemisr_challenge05.MovieDetailsResponse?, banquemisr_challenge05.NetworkError>) -> Void)?) {
        
    }
}
