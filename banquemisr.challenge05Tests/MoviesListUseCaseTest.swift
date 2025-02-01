//
//  Untitled.swift
//  MoviesListUseCaseTest.challenge05
//
//  Created by Moe Salah  on 01/02/2025.
//
import XCTest
@testable import banquemisr_challenge05

final class MoviesListUseCaseTest: XCTestCase {
    
    let movies: Movie = Movie(title: "Title", release_date: "2025", poster_path: "path", original_language: "EN")
    var completion: ((Result<ListResponse?, NetworkError>) -> Void)?
    
    func testSuccessMoviesUseCase() {
        let sut = makeSUT()
        let moviesResult = sut.fetchMovies(type: MovieType.popular, completion: completion)
    }
    
    // MARK: - Helpers
    public func makeSUT() -> MoviesListUseCase {
        return  MoviesListUseCase(repo: MockMoviesRepo())
    }
}
