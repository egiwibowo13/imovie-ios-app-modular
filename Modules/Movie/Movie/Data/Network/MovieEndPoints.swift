//
//  MovieEndPoints.swift
//  Movie
//
//  Created by Egi Wibowo on 06/10/21.
//

import Foundation
import Core

class MovieEndpoints {
  func getMovie(id: Int) -> Endpoint<MoviesResponseDTO.MovieDTO> {
    return Endpoint(path: "3/movie/\(id)", method: .get)
  }
  
  func getMovieCastAndCrew(id: Int) -> Endpoint<CastAndCrewResponseDTO> {
    return Endpoint(path: "3/movie/\(id)/credits", method: .get)
  }
  
  func getMoviesRecommendation(id: Int, request: MoviesRequestDTO) -> Endpoint<MoviesResponseDTO> {
    return Endpoint(path: "3/movie/\(id)/recommendations", method: .get, body: request)
  }
  
  func getImagesById(id: Int) -> Endpoint<PhotosResponseDTO> {
    return Endpoint(path: "3/movie/\(id)/images", method: .get)
  }
}
