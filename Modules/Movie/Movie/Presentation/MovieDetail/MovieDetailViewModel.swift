//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by Egi Wibowo on 05/10/21.
//

import Foundation
import Combine
import Core

class MovieDetailViewModel: ObservableObject {
  
  @Published var movie: BaseResult<Movie> = BaseResult()
  @Published var moviesRecommend: BaseResult<[Movie]> = BaseResult(data: [])
  @Published var photos: BaseResult<[Photo]> = BaseResult(data: [])
  @Published var castsAndCrews: BaseResult<[CastAndCrew]> = BaseResult(data: [])
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let movieUseCase: MovieDetailUseCase
  var movieId: Int
  
  init(movieId: Int, movieUseCase: MovieDetailUseCase) {
    self.movieId = movieId
    self.movieUseCase = movieUseCase
    
    getMovie()
    getCastAndCrew()
    getMovieRecommendation()
    getPhotos()
  }
  
  func getCastCrewsLimit() -> [CastAndCrew] {
    let castAndCrews: [CastAndCrew] = castsAndCrews.data ?? []
    let castLength = castAndCrews.count
    if castLength > 5 {
      return Array(castAndCrews[0...4])
    } else if castLength > 0 {
      return Array(castAndCrews[0...castLength - 1])
    }
    return []
  }
  
  func getTitleText() -> String {
    if let title = movie.data?.title {
      return title
    } else {
      return "..."
    }
  }
  
  func getMovie() {
    movie = BaseResult.loading()
    self.movieUseCase.getMovieDetail(movieId: self.movieId)
      .sink { completion in
        switch completion {
        case .failure(let err):
          self.movie = BaseResult.error(error: err)
        default: break
        }
      } receiveValue: { movie in
        self.movie = BaseResult.success(data: movie)
      }.store(in: &cancellables)
  }
  
  func getCastAndCrew() {
    self.castsAndCrews = BaseResult.loading()
    self.movieUseCase.getCastsAndCrews(movieId: self.movieId)
      .sink { completion in
        switch completion {
        case .failure(let err):
          self.castsAndCrews = BaseResult.error(error: err)
        default: break
        }
      } receiveValue: { castsandCres in
        self.castsAndCrews = BaseResult.success(data: castsandCres)
      }.store(in: &cancellables)
  }
  
  func getMovieRecommendation() {
    self.moviesRecommend = BaseResult.loading()
    self.movieUseCase.getMoviesRecommendation(movieId: self.movieId, request: MoviesRequestDTO(page: 1))
      .sink { completion in
        switch completion {
        case .failure(let err):
          self.moviesRecommend = BaseResult.error(error: err)
        default: break
        }
      } receiveValue: { moviesPage in
        self.moviesRecommend = BaseResult.success(data: moviesPage.movies)
      }.store(in: &cancellables)
  }
  
  func getPhotos() {
    self.photos = BaseResult.loading()
    self.movieUseCase.getImages(movieId: self.movieId)
      .sink { completion in
        switch completion {
        case .failure(let err):
          self.photos = BaseResult.error(error: err)
        default: break
        }
      } receiveValue: { photos in
        self.photos = BaseResult.success(data: photos)
      }.store(in: &cancellables)
  }
  
  func saveMovie() {
    if self.movie.data != nil && !self.movie.data!.isFavorit {
      self.movieUseCase.saveMovieToFavorite(movie: self.movie.data!)
        .sink { completion in
          switch completion {
          case .failure:
            self.movie.data?.isFavorit = false
          default: break
          }
        } receiveValue: { _ in
          self.movie.data?.isFavorit = true
        }.store(in: &cancellables)
    } else if self.movie.data != nil {
      self.movieUseCase.deleteMovieFromFavorite(movie: self.movie.data!)
        .sink { completion in
          switch completion {
          case .failure:
            self.movie.data?.isFavorit = true
          default: break
          }
        } receiveValue: { _ in
          self.movie.data?.isFavorit = false
        }.store(in: &cancellables)
    }
  }
}
