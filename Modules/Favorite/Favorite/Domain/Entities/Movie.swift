//
//  Movie.swift
//  Favorite
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation

struct Movie: Identifiable {
  let _id = UUID()
  let id: Int
  let title: String
  let description: String
  let backdropUrl: String
  let posterUrl: String
  let voteAverage: Double
  let totalVote: Int
  let releaseDate: Date
  
  var isFavorit: Bool = false
  
  var rating: Int {
    Int(voteAverage / 2)
  }
  
  var releaseDateView: String {
    dateFormatter.string(from: releaseDate)
  }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
