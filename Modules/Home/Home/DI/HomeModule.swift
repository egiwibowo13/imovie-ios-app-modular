//
//  HomeModule.swift
//  Home
//
//  Created by Egi Wibowo on 04/10/21.
//

import Foundation
import Abstract

class HomeModule {
  
  func provideApiDataConfig() -> NetworkConfigurable {
    return ApiDataNetworkConfig(
      baseURL: URL(string: "https://api.themoviedb.org")!,
      apiKey: "74078d381713cfc6b144cc4fc1e7aaef")
  }
  
  func provideApiClient() -> ApiClient {
    return ApiClient(config: provideApiDataConfig())
  }
  
  func provideHomeEndpoints() -> HomeEndpoints {
    return HomeEndpoints()
  }
  
  func provideHomeServices() -> HomeServices {
    return HomeServices(apiClient: provideApiClient(), endpoints: provideHomeEndpoints())
  }
  
  func provideHomeRepository() -> HomeRepository {
    return HomeRepositoryImp.sharedInstance(provideHomeServices())
  }
  
  func homeUseCase() -> HomeUseCase {
    return HomeInteractor(homeRepo: provideHomeRepository())
  }
  
}
