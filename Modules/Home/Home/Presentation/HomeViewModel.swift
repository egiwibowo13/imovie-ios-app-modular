//
//  HomeViewModel.swift
//  Home
//
//  Created by Egi Wibowo on 04/10/21.
//

import Foundation
import Combine
import Abstract

class HomeViewModel: ObservableObject {
  
  @Published var activeBtnId: Int = 0
  @Published var movies: BaseResult<[Movie]> = BaseResult(data: [])
  @Published var loadMoreState: BaseResult<Bool> = BaseResult()
  
  private var page: Int = 1
  private var totalPage: Int = 1
  
  private let homeUsecase: HomeUseCase
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(homeUsecase: HomeUseCase) {
    self.homeUsecase = homeUsecase
    
    getMoviesUpcoming()
  }
  
  func getMoviesNowPlaying() {
    self.movies = BaseResult.loading()
    self.homeUsecase.getMoviesNowPlaying(
      request: MoviesRequestDTO(page: page)
    )
      .sink { completion in
        switch completion {
        case .failure(let err):
          self.movies = BaseResult.error(error: err)
        default: break
        }
    } receiveValue: { (moviPages) in
      self.movies = BaseResult.success(data: moviPages.movies)
      self.page += 1
      self.totalPage = moviPages.totalPages
    }
    .store(in: &cancellables)
  }
  
  func getMoviesUpcoming() {
    self.movies = BaseResult.loading()
    self.homeUsecase.getMoviesUpcoming(
      request: MoviesRequestDTO(page: page)
    )
      .sink { completion in
        switch completion {
        case .failure(let err):
          self.movies = BaseResult.error(error: err)
        default: break
        }
    } receiveValue: { (moviPages) in
      self.movies = BaseResult.success(data: moviPages.movies)
      self.page += 1
      self.totalPage = moviPages.totalPages
    }
    .store(in: &cancellables)
  }
  
  func loadMoreContentIfNeeded(currentItem movie: Movie?) {
     guard let movie = movie else {
       loadMoreContent()
       return
     }
    
    let dataMovies = movies.data ?? []

    let thresholdIndex = dataMovies.index(dataMovies.endIndex, offsetBy: -5)
     if dataMovies.firstIndex(where: { $0.id == movie.id }) == thresholdIndex {
        loadMoreContent()
     }
   }
  
  func loadMoreContent() {
    guard !self.loadMoreState.loading && self.page < self.totalPage else {
         return
       }
    loadMoreState = BaseResult.loading()
    if activeBtnId == 0 {
      self.homeUsecase.getMoviesNowPlaying(
        request: MoviesRequestDTO(page: page)
      )
        .sink { completion in
          switch completion {
          case .failure(let err):
            self.loadMoreState = BaseResult.error(error: err)
          default: break
          }
      } receiveValue: { (moviPages) in
        self.loadMoreState = BaseResult.success(data: true)
        let prevMovies = self.movies.data ?? []
        self.movies.data = prevMovies + moviPages.movies
        self.page += 1
      }
      .store(in: &cancellables)
    } else {
      self.homeUsecase.getMoviesUpcoming(
        request: MoviesRequestDTO(page: page)
      )
        .sink { completion in
          switch completion {
          case .failure(let err):
            self.loadMoreState = BaseResult.error(error: err)
          default: break
          }
      } receiveValue: { (moviPages) in
        self.loadMoreState = BaseResult.success(data: true)
        let prevMovies = self.movies.data ?? []
        self.movies.data = prevMovies + moviPages.movies
        self.page += 1
      }
      .store(in: &cancellables)
    }
 
  }
  
  func changeActiveBtnId(id: Int) {
    activeBtnId = id
    page = 1
    if id == 0 {
      getMoviesNowPlaying()
    } else {
      getMoviesUpcoming()
    }
  }

}
