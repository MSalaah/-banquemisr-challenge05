//
//  MovieDetails.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 30/01/2025.
//
import Foundation

struct MovieDetailsResponse: Codable {
    var adult: Bool
    var backdrop_path: String
    var belongs_to_collection: BelongsToCollection
    var budget: Int64
    var genres: [Genre]
    var homepage: String
    var id: Int64
    var imdb_id: String
    var origin_country: [String]
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float
    var poster_path: String
    var production_companies: [ProductionCompanies]
    var production_countries: [ProductionCountries]
    var release_date: String
    var revenue: Int64
    var runtime: Int
    var spoken_languages: SpokenLanguages
    var status: String
    var tagline: String
    var title: String
    var video: Bool
    var vote_average: Float
    var vote_count: Int
}
struct BelongsToCollection: Codable {
    var id: Int
    var name: String
    var poster_path: String
    var backdrop_path: String
}
struct Genre: Codable {
    var id: Int
    var name: String
}
struct ProductionCompanies: Codable {
    var id: Int
    var logo_path: String
    var name: String
    var origin_country: String
}

struct ProductionCountries: Codable {
    var iso_3166_1: String
    var name: String
}
struct SpokenLanguages: Codable {
    var iso_3166_1: String
    var name: String
    var english_name: String
}

