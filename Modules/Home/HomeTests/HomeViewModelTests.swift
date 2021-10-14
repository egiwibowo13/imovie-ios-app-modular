//
//  HomeViewModelTests.swift
//  HomeTests
//
//  Created by Egi Wibowo on 14/10/21.
//

import XCTest
@testable import Home
import Core

class HomeViewModelTests: XCTestCase {
  
  var viewModel: HomeViewModel!
  var mockHomeUseCase: MockHomeUseCase!

  override func setUp() {
    mockHomeUseCase = MockHomeUseCase()
    viewModel = .init(homeUsecase: mockHomeUseCase)
  }
  
  func test_getNowPlayingMoviesSuccess() {
    let movies: [Movie] = Movie.getMockMovies(num: 10)
    mockHomeUseCase.getMoviesResult = .success(MoviesPage(page: 1, totalPages: 10, movies: movies))
    viewModel.getMoviesNowPlaying()
    
    XCTAssertTrue(viewModel.movies.isSuccess)
    XCTAssertFalse(viewModel.movies.isError)
    XCTAssertEqual(movies.count, viewModel.movies.data!.count)
  }
  
  func test_getNowPlayingMoviesFailure() {
    
    mockHomeUseCase.getMoviesResult = .failure(APIError.error(message: "error"))
    viewModel.getMoviesNowPlaying()
    
    XCTAssertFalse(viewModel.movies.isSuccess)
    XCTAssertTrue(viewModel.movies.isError)
    XCTAssertNil(viewModel.movies.data)
  }
  
  func test_neededLoadMoreNowPlaying() {
    
    let movies: [Movie] = Movie.getMockMovies(num: 10)
    mockHomeUseCase.getMoviesResult = .success(MoviesPage(page: 1, totalPages: 10, movies: movies))
    viewModel.getMoviesNowPlaying()
    
    let scrollMovieAt5 = movies[5]
    
    viewModel.loadMoreContentIfNeeded(currentItem: scrollMovieAt5)
    
    XCTAssertEqual(20, viewModel.movies.data!.count)
    
  }
  
  func test_noNeededLoadMoreNowPlaying() {
    let movies: [Movie] = Movie.getMockMovies(num: 10)
    mockHomeUseCase.getMoviesResult = .success(MoviesPage(page: 1, totalPages: 1, movies: movies))
    viewModel.getMoviesNowPlaying()
    
    let scrollMovieAt5 = movies[5]
    
    viewModel.loadMoreContentIfNeeded(currentItem: scrollMovieAt5)
    
    XCTAssertEqual(10, viewModel.movies.data!.count)
  }
  
  func test_getUpcomingMoviesSuccess() {
    let expectedMovies: [Movie] = [Movie.example]
    mockHomeUseCase.getMoviesResult = .success(MoviesPage(page: 1, totalPages: 1, movies: expectedMovies))
    viewModel.getMoviesUpcoming()
    
    XCTAssertTrue(viewModel.movies.isSuccess)
    XCTAssertFalse(viewModel.movies.isError)
    XCTAssertEqual(expectedMovies.count, viewModel.movies.data!.count)
  }
  
  func test_getUpcomingMoviesFailure() {
    let expectedMovies: [Movie] = [Movie.example]
    mockHomeUseCase.getMoviesResult = .success(MoviesPage(page: 1, totalPages: 1, movies: expectedMovies))
    viewModel.getMoviesUpcoming()
    
    XCTAssertTrue(viewModel.movies.isSuccess)
    XCTAssertFalse(viewModel.movies.isError)
    XCTAssertEqual(expectedMovies.count, viewModel.movies.data!.count)
  }

}
