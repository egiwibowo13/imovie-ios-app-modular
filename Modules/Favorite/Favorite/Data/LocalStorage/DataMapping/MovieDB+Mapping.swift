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
      releaseDate: releaseDate.toDate(format: "dd MMM yyyy") ?? Date()
    )
  }
}
