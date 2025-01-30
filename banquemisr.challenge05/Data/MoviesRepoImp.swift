//
//  MoviesRepoImp.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 29/01/2025.
//
import Foundation

class MoviesRepoImp: MoviesRepoContract {
    
    private let apiClient: APIProtocol
    
    init(apiClient: APIProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchMovies(type: MovieType, completion: ((Result<ListResponse?, NetworkError>) -> Void)?) {
        guard let urlReq = prepareUrl(path: "/movie/\(type.rawValue)") else { return }
        //        --url 'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1' \
        //        apiClient?.executeRequest(urlRequest: urlRequest, completion: completion)
        apiClient.executeRequest(urlRequest: urlReq) { result in
            completion?(result)
        }
    }
    
    func fetchPopularMovies(completion: ((Result<ListResponse?, NetworkError>) -> Void)?) {
        guard let urlRequest = prepareUrl(path: "/movie/popular") else { return }
        apiClient.executeRequest(urlRequest: urlRequest) { result in
            completion?(result)
        }
    }
    
    func fetchUpcomingMovies(completion: ((Result<ListResponse?, NetworkError>) -> Void)?) {
        guard let urlRequest = prepareUrl(path: "/movie/upcoming") else { return }
        apiClient.executeRequest(urlRequest: urlRequest) { result in
            completion?(result)
        }
    }
    
    func fetchNowPlayingMovies(completion: ((Result<ListResponse?, NetworkError>) -> Void)?) {
        guard let urlRequest = prepareUrl(path: "/movie/now_playing") else { return }
        apiClient.executeRequest(urlRequest: urlRequest) { result in
            completion?(result)
        }
    }
    
    func fetchMovieDetails(movieId: Int, completion: ((Result<MovieDetailsResponse?, NetworkError>) -> Void)?) {
        guard let urlRequest = prepareUrl(path: "/movie") else { return }
        apiClient.executeRequest(urlRequest: urlRequest) { result in
            completion?(result)
        }
    }
    private func prepareUrl(path: String = "") -> URLRequest? {
        guard let url = URL(string: "\(apiClient.baseUrl)\(path)") else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
        urlRequest.setValue("Bearer \(Constants.apiToken)", forHTTPHeaderField:"Authorization")
        urlRequest.timeoutInterval = 60.0
        
        return urlRequest
    }
}
