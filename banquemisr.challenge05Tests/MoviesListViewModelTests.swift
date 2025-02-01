//
//  MoviesListViewModelTests.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 01/02/2025.
//

import XCTest
@testable import banquemisr_challenge05

class MoviesListViewModelTests: XCTestCase {
    
    var useCase: MoviesListUseCaseProtocol!
    var sut: MoviesListViewModel!
    
    override func setUp() {
        super.setUp()
        useCase =  MoviesListUseCase(repo: MockMoviesRepo())
        sut = MoviesListViewModel(moviesListUseCase: useCase)
    }
    
    override func tearDown() {
        sut = nil
        useCase = nil
        super.tearDown()
    }
    
    func test_fetch_movies() {
        
    }
}
