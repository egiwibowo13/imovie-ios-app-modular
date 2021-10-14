//
//  Movie.swift
//  Home
//
//  Created by Egi Wibowo on 30/09/21.
//

import Foundation

let MAX_AVG = 10

struct Movie: Equatable, Identifiable {
  typealias Identifier = Int
  let ids = UUID()
  let id: Identifier
  let title: String
  let posterUrl: String
  let voteAverage: Double
  let totalVote: Int
  let releaseDate: Date
  
  var rating: Int {
    Int(voteAverage / 2)
  }
  
  var releaseDateView: String {
    dateFormatter.string(from: releaseDate)
  }
  
  static var example: Movie {
    Movie(
      id: 1,
      title: "Revenge",
      posterUrl: "https://image.tmdb.org/t/p/w500/8b22sVNbNruOcF6gv0PuhxcLFf3.jpg",
      voteAverage: 4.5,
      totalVote: 100,
      releaseDate: Date())
  }
}

struct MoviesPage: Equatable {
  let page: Int
  let totalPages: Int
  let movies: [Movie]
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
