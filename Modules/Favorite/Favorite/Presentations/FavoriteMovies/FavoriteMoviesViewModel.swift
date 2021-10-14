//
//  FavoriteMoviesViewModel.swift
//  Favorite
//
//  Created by Egi Wibowo on 11/10/21.
//

import Foundation
import Combine

class FavoriteMoviesViewModel: ObservableObject {

  @Published var movies: [Movie] = []
  private let favoriteUseCase: FavoriteUseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
    
    getFavoriteMovies()
  }
  
  func getFavoriteMovies() {
    self.favoriteUseCase.getFavoriteMovies()
      .sink { completion in
        switch completion {
        case .failure(let err):
          print(err)
        case .finished:
          print("finish")
        }
      } receiveValue: { movies in
        self.movies = movies
      }.store(in: &cancellables)
  }
  
}
