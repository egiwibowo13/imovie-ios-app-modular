//
//  MovieResponseDB+Mapping.swift
//  Movie
//
//  Created by Egi Wibowo on 08/10/21.
//

import Foundation
import Core

import RealmSwift

public class MovieEntity: Object {

  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var poster: String = ""

  public override static func primaryKey() -> String? {
    return "id"
  }
}

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
      releaseDate: dateFormatter.date(from: releaseDate) ?? Date(),
      genres: genres,
      runtime: runtime,
      isFavorit: true
    )
  }
}

extension Movie {
  func toDB() -> MovieDB {
    let movieDB = MovieDB()
    movieDB.id = id
    movieDB.title = title
    movieDB.backdropUrl = backdropUrl
    movieDB.posterUrl = posterUrl
    movieDB.overview = description
    movieDB.totalVote = totalVote
    movieDB.voteAverage = voteAverage
    movieDB.releaseDate = dateFormatter.string(from: releaseDate)
    movieDB.genres = genres
    movieDB.runtime = runtime
    return movieDB
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
