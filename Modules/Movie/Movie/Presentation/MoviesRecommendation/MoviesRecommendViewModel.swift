//
//  MoviesRecommendViewModel.swift
//  Movie
//
//  Created by Egi Wibowo on 07/10/21.
//

import Foundation
import Combine

class MoviesRecommendViewModel: ObservableObject {
  
  @Published var moviesRecommend: [Movie] = []
  @Published var castsAndCrews: [CastAndCrew] = []
  @Published var loading: Bool = false
  @Published var loadingPage: Bool = false
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let movieUseCase: MovieDetailUseCase
  var movieId: Int
  private var page: Int = 1
  private var totalPage: Int = 1
  
  init(movieId: Int, movieUseCase: MovieDetailUseCase) {
    self.movieId = movieId
    self.movieUseCase = movieUseCase
    
    getMovieRecommendation()
  }
  
  func getMovieRecommendation() {
    loading = true
    self.movieUseCase.getMoviesRecommendation(movieId: self.movieId, request: MoviesRequestDTO(page: 1))
      .sink { completion in
        switch completion {
        case .failure(let err):
          print("err")
          print(err)
        case .finished:
          print("finish")
          self.loading = false
        }
      } receiveValue: { moviesPage in
        self.moviesRecommend = moviesPage.movies
      }.store(in: &cancellables)
  }
  
  func loadMoreContent() {
    guard !self.loadingPage && self.page < self.totalPage else {
         return
       }
    
    loadingPage = true
      self.movieUseCase.getMoviesRecommendation(
        movieId: self.movieId,
        request: MoviesRequestDTO(page: page)
      )
        .sink { completion in
          switch completion {
          case .failure:
            print("error")
          case .finished:
            self.loadingPage = false
          }
      } receiveValue: { (moviesPages) in
        self.moviesRecommend += moviesPages.movies
        self.page += 1
      }
      .store(in: &cancellables)
  }
}
