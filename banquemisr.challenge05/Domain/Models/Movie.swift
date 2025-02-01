//
//  Movie.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 29/01/2025.
//

import Foundation

enum MovieType: String {
    case popular = "popular"
    case upComing = "upcoming"
    case nowPlaying = "now_playing"
}

struct ListResponse: Codable {
    var dates: Dates?
    var page: Int
    var results: [Movie]
}

struct Dates: Codable {
    var maximum: String
    var minimum: String
}

struct Movie: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Decimal?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Decimal?
    var vote_count: Int?
    
    init(title: String, release_date: String, poster_path: String, original_language: String) {
        self.title = title
        self.release_date = release_date
        self.poster_path = poster_path
        self.original_language = original_language
    }
}
