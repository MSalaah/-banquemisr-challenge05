//
//  MoviesRepoContract.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 29/01/2025.
//

protocol MoviesRepoContract {
    func fetchMovies(type: MovieType, completion: ((Result<ListResponse?, NetworkError>) -> Void)?)

    func fetchPopularMovies(completion: ((Result<ListResponse?, NetworkError>) -> Void)?)
    
    func fetchUpcomingMovies(completion: ((Result<ListResponse?, NetworkError>) -> Void)?)
    
    func fetchNowPlayingMovies(completion: ((Result<ListResponse?, NetworkError>) -> Void)?)
    
    func fetchMovieDetails(movieId: Int, completion: ((Result<MovieDetailsResponse?, NetworkError>) -> Void)?)
}

