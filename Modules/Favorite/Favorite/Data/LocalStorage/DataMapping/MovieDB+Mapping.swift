//
//  MovieDB+Mapping.swift
//  Favorite
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import Core

extension MovieDB {
  func toDomain() -> Movie {
    Movie(
      id: id,
      title: title,
      description: overview,
      backdropUrl: backdropUrl,
      posterUrl: posterUrl,
      voteAverage: voteAverage,
      totalVote: totalVote,
      releaseDate: dateFormatter.date(from: releaseDate) ?? Date()
    )
  }
}

// MARK: - Private
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
