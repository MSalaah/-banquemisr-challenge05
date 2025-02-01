//
//  MoviesRepoContract.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 29/01/2025.
//

/*
 This protocol is the contract between data and domain as the domain cant access the data layer directly
 */
protocol MoviesRepoContract {
    func fetchMovies(type: MovieType, completion: ((Result<ListResponse?, NetworkError>) -> Void)?)
    func fetchMovieDetails(movieId: Int, completion: ((Result<MovieDetailsResponse?, NetworkError>) -> Void)?)
}

