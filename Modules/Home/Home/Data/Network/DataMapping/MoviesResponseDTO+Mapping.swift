//
//  MoviesResponseDTO+Mapping.swift
//  Home
//
//  Created by Egi Wibowo on 30/09/21.
//

import Foundation
import Abstract

struct MoviesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
      case page
      case totalPages = "total_pages"
      case movies = "results"
    }
    let page: Int
    let totalPages: Int
    let movies: [MovieDTO]
}

extension MoviesResponseDTO {
    struct MovieDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
          case id
          case title
          case genre
          case posterPath = "poster_path"
          case overview
          case releaseDate = "release_date"
          case voteAverage = "vote_average"
          case totalVote = "vote_count"
        }
      let id: Int
      let title: String?
      let genre: String?
      let posterPath: String?
      let overview: String?
      let releaseDate: String?
      let voteAverage: Double?
      let totalVote: Int
    }
}

// MARK: - Mappings to Domain
extension MoviesResponseDTO {
    func toDomain() -> MoviesPage {
        return .init(page: 1,
                     totalPages: totalPages,
                     movies: movies.map { $0.toDomain() })
    }
}

extension MoviesResponseDTO.MovieDTO {
    func toDomain() -> Movie {
      Movie(
        id: Movie.Identifier(id),
        title: title ?? "",
        posterUrl: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")",
        voteAverage: voteAverage ?? 0.0,
        totalVote: totalVote,
        releaseDate: releaseDate?.toDate(format: "yyy-MM-dd") ?? Date()
      )
    }
}
