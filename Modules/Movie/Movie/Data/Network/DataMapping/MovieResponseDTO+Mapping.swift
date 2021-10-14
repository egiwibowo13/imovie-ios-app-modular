//
//  MovieResponseDTO+Mapping.swift
//  Movie
//
//  Created by Egi Wibowo on 06/10/21.
//

import Foundation
import Core

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

// MARK: - Mappings to Domain
extension MoviesResponseDTO {
    func toDomain() -> MoviesPage {
        return .init(page: 1,
                     totalPages: 1,
                     movies: movies.map { $0.toDomain() })
    }
}

extension MoviesResponseDTO {
  struct MovieDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case genre
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case totalVote = "vote_count"
        case genres = "genres"
        case runtime = "runtime"
      }
    let id: Int
    let title: String?
    let genre: String?
    let posterPath: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    let totalVote: Int
    let genres: [Genre]?
    let runtime: Int?
  }
}

// MARK: - Mappings to Domain
extension MoviesResponseDTO.MovieDTO {
  
  struct Genre: Decodable {
    let id: Int
    let name: String
  }
  
    func toDomain() -> Movie {
      let nGenres = genres ?? []
      return Movie(
        id: id,
        title: title ?? "Untitled Movie",
        description: overview ?? "Dont have overview",
        backdropUrl: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")",
        posterUrl: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")",
        voteAverage: voteAverage ?? 0.0,
        totalVote: totalVote,
        releaseDate: releaseDate?.toDate(format: "yyyy-MM-dd") ?? Date(),
        genres: nGenres.map { genre in
          genre.name
        }.joined(separator: ", "),
        runtime: runtime ?? 0
      )
    }
}
