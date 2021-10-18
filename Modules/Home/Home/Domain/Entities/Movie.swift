//
//  Movie.swift
//  Home
//
//  Created by Egi Wibowo on 30/09/21.
//

import Foundation
import Core
import Abstract

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
    releaseDate.toString(format: "dd MMM yyyy")
  }
}

struct MoviesPage: Equatable {
  let page: Int
  let totalPages: Int
  let movies: [Movie]
}
