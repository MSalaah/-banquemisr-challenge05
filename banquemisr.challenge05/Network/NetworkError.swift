//
//  NetworkError.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 30/01/2025.
//
 
import Foundation

enum NetworkError: Error, LocalizedError {
    
    case noInternetConnection
    case invalidData
    case internalServerError
    case unknownError
    case unknownErrorBio
    case unauthorized
    case unauthorizedBio
    case decodingFailed
    
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No internet connection"
        case .invalidData, .internalServerError, .unknownError, .unknownErrorBio:
            return "Something went wrong"
        case .unauthorized:
            return "Unauthorized"
        case .unauthorizedBio:
            return "Unauthorized Biometric"
        case .decodingFailed:
            return "Decoding Failed"
        }
    }
}
