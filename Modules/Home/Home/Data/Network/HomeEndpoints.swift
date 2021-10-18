//
//  HomeEndpoints.swift
//  Home
//
//  Created by Egi Wibowo on 04/10/21.
//

import Foundation
import Core
import Abstract

class HomeEndpoints {
  func getMoviesNowPlaying(request: MoviesRequestDTO) -> Endpoint<MoviesResponseDTO> {
    return Endpoint(path: "3/movie/now_playing", method: .get, body: request)
  }
  
  func getMoviesUpcoming(request: MoviesRequestDTO) -> Endpoint<MoviesResponseDTO> {
    return Endpoint(path: "3/movie/upcoming", method: .get, body: request)
  }
}
