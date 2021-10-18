//
//  Injector.swift
//  Movie
//
//  Created by Egi Wibowo on 22/09/21.
//

import Foundation
import Abstract
import Core

class MovieInjector {
  func provideApiDataConfig() -> NetworkConfigurable {
    return ApiDataNetworkConfig(
      baseURL: URL(string: "https://api.themoviedb.org")!,
      apiKey: "74078d381713cfc6b144cc4fc1e7aaef")
  }
  
  func provideApiClient() -> ApiClient {
    return ApiClient(config: provideApiDataConfig())
  }
  
  func provideMovieEndpoints() -> MovieEndpoints {
    return MovieEndpoints()
  }
  
  func provideMovieServices() -> MovieServices {
    return MovieServices(apiClient: provideApiClient(), endpoints: provideMovieEndpoints())
  }
  
  func provideMovieRepository() -> MovieRepository {
    return MovieRepositoryImp.sharedInstance(provideMovieServices(), CoreInjector().provideRealmDatabase())
  }
  
  func provideMovieDetailUseCase() -> MovieDetailUseCase {
    return MovieDetailInteractor(movieRepo: provideMovieRepository())
  }
}
