//
//  MockMovie.swift
//  MovieTests
//
//  Created by Egi Wibowo on 14/10/21.
//

import Foundation
@testable import Movie

extension Movie {
  
  static func getMock(id: Int) -> Movie {
    Movie(
      id: id,
      title: "Revenge",
      description: "descriptions",
      backdropUrl: "https://image.tmdb.org/t/p/w500/8b22sVNbNruOcF6gv0PuhxcLFf3.jpg",
      posterUrl: "https://image.tmdb.org/t/p/w500/8b22sVNbNruOcF6gv0PuhxcLFf3.jpg",
      voteAverage: 4.5,
      totalVote: 100,
      releaseDate: Date(),
      genres: "Action",
      runtime: 100
      )
  }
  
  static func getMockMovies(num: Int) -> [Movie] {
    var movies: [Movie] = []
    for n in 1...num {
      movies.append(Movie.getMock(id: n))
    }
    return movies
  }
}

extension MoviesPage {
  static func getMock() -> MoviesPage {
    MoviesPage(page: 1, totalPages: 10, movies: Movie.getMockMovies(num: 10))
  }
}
