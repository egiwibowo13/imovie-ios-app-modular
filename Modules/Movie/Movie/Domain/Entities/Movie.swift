//
//  File.swift
//  Movie
//
//  Created by Egi Wibowo on 02/10/21.
//

import Foundation
import Core

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
  let genres: String
  let runtime: Int
  
  var isFavorit: Bool = false
  
  var rating: Int {
    Int(voteAverage / 2)
  }
  
  var releaseDateView: String {
    releaseDate.toString(format: "dd MMM yyyy")
  }
  
  var runtimeView: String {
    runtime.convertMinutesToRunTimes(style: .abbreviated)
  }
  
  static let _default = Movie(
    id: 0,
    title: "untitled",
    description: "",
    backdropUrl: "",
    posterUrl: "",
    voteAverage: 0.0,
    totalVote: 0,
    releaseDate: Date(),
    genres: "",
    runtime: 0
  )
}

struct MoviesPage {
  let page: Int
  let totalPages: Int
  let movies: [Movie]
}
