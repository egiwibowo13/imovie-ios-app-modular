//
//  MovieDetailViewModelTests.swift
//  MovieTests
//
//  Created by Egi Wibowo on 14/10/21.
//

import XCTest
@testable import Movie
import Abstract

class MovieDetailViewModelTests: XCTestCase {

  var viewModel: MovieDetailViewModel!
  var mockMovieDetailUseCase: MockMovieDetailUseCase!

  override func setUp() {
    mockMovieDetailUseCase = MockMovieDetailUseCase()
    viewModel = .init(movieId: 1, movieUseCase: mockMovieDetailUseCase)
  }
  
  func test_getMovieSuccess() {
    let expectedMovie = Movie.getMock(id: 1)
    mockMovieDetailUseCase.getMovieResult = .success(expectedMovie)
    
    viewModel.getMovie()
    
    XCTAssertTrue(viewModel.movie.isSuccess)
    XCTAssertEqual(viewModel.getTitleText(), expectedMovie.title)
  }
  
  func test_getMovieFailure() {
    mockMovieDetailUseCase.getMovieResult = .failure(APIError.error(message: "error"))
    
    viewModel.getMovie()
    
    XCTAssertTrue(viewModel.movie.isError)
    XCTAssertEqual(viewModel.getTitleText(), "...")
    XCTAssertNil(viewModel.movie.data)
  }
  
  func test_getPhotosSuccess() {
    let expectedPhotos = Photo.getMockPhotos(num: 10)
    mockMovieDetailUseCase.getPhotosResult = .success(expectedPhotos)
    
    viewModel.getPhotos()
    
    XCTAssertTrue(viewModel.photos.isSuccess)
    XCTAssertEqual(expectedPhotos.count, viewModel.photos.data?.count)
  }
  
  func test_getPhotosFailure() {
    mockMovieDetailUseCase.getPhotosResult = .failure(APIError.error(message: "error"))
    
    viewModel.getPhotos()
    
    XCTAssertTrue(viewModel.photos.isError)
    XCTAssertNil(viewModel.photos.data)
  }
  
  func test_getRecommendSuccess() {
    let expectedRecommend = MoviesPage.getMock()
    mockMovieDetailUseCase.getMoviesRecommendResult = .success(expectedRecommend)

    viewModel.getMovieRecommendation()

    XCTAssertTrue(viewModel.moviesRecommend.isSuccess)
    XCTAssertEqual(expectedRecommend.movies.count, viewModel.moviesRecommend.data?.count)
  }
  
  func test_getRecommendFailure() {
    mockMovieDetailUseCase.getMoviesRecommendResult = .failure(APIError.error(message: "error"))

    viewModel.getMovieRecommendation()

    XCTAssertTrue(viewModel.moviesRecommend.isError)
    XCTAssertNil(viewModel.moviesRecommend.data)
  }
  
  func test_getCastAndCrewsSuccessDataMoreThan5() {
    let extectedCastAndCrews = CastAndCrew.getMockCastAndCrews(num: 10)
    mockMovieDetailUseCase.getCastAndCrewsResult = .success(extectedCastAndCrews)
    
    viewModel.getCastAndCrew()
    
    XCTAssertTrue(viewModel.castsAndCrews.isSuccess)
    XCTAssertEqual(extectedCastAndCrews.count, viewModel.castsAndCrews.data?.count)
    XCTAssertEqual(viewModel.getCastCrewsLimit().count, 5)
  }
  
  func test_getCastAndCrewsSuccessDataMoreThan0AndLessThan5() {
    let extectedCastAndCrews = CastAndCrew.getMockCastAndCrews(num: 4)
    mockMovieDetailUseCase.getCastAndCrewsResult = .success(extectedCastAndCrews)
    
    viewModel.getCastAndCrew()
    
    XCTAssertTrue(viewModel.castsAndCrews.isSuccess)
    XCTAssertEqual(extectedCastAndCrews.count, viewModel.castsAndCrews.data?.count)
    XCTAssertEqual(viewModel.getCastCrewsLimit().count, 4)
  }
  
  func test_getCastAndCrewFailure() {
    mockMovieDetailUseCase.getCastAndCrewsResult = .failure(APIError.error(message: "error"))
    
    viewModel.getCastAndCrew()
    
    XCTAssertTrue(viewModel.castsAndCrews.isError)
    XCTAssertNil(viewModel.castsAndCrews.data)
    XCTAssertEqual(viewModel.getCastCrewsLimit().count, 0)
  }
  
  func test_saveMovieSuccess() {
    var movie = Movie.getMock(id: 1)
    movie.isFavorit = false
    mockMovieDetailUseCase.getMovieResult = .success(movie)
    mockMovieDetailUseCase.favoriteResult = .success(true)
    
    viewModel.getMovie()
    
    XCTAssertNotNil(viewModel.castsAndCrews.data)
    XCTAssertFalse(viewModel.movie.data!.isFavorit)
    
    viewModel.saveMovie()
    XCTAssertNotNil(viewModel.castsAndCrews.data)
    XCTAssertTrue(viewModel.movie.data!.isFavorit)
  }
  
  func test_saveMovieFailure() {
    var movie = Movie.getMock(id: 1)
    movie.isFavorit = false
    mockMovieDetailUseCase.getMovieResult = .success(movie)
    mockMovieDetailUseCase.favoriteResult = .failure(APIError.error(message: "error"))
    
    viewModel.getMovie()
    
    XCTAssertNotNil(viewModel.castsAndCrews.data)
    XCTAssertFalse(viewModel.movie.data!.isFavorit)
    
    viewModel.saveMovie()
    XCTAssertNotNil(viewModel.castsAndCrews.data)
    XCTAssertFalse(viewModel.movie.data!.isFavorit)
  }
  
  func test_deleteMovieSuccess() {
    var movie = Movie.getMock(id: 1)
    movie.isFavorit = true
    mockMovieDetailUseCase.getMovieResult = .success(movie)
    mockMovieDetailUseCase.favoriteResult = .success(true)
    
    viewModel.getMovie()
    
    XCTAssertNotNil(viewModel.castsAndCrews.data)
    XCTAssertTrue(viewModel.movie.data!.isFavorit)
    
    viewModel.saveMovie()
    XCTAssertNotNil(viewModel.castsAndCrews.data)
    XCTAssertFalse(viewModel.movie.data!.isFavorit)
  }
  
  func test_deleteMovieFailure() {
    var movie = Movie.getMock(id: 1)
    movie.isFavorit = true
    mockMovieDetailUseCase.getMovieResult = .success(movie)
    mockMovieDetailUseCase.favoriteResult = .failure(APIError.error(message: "error"))
    
    viewModel.getMovie()
    
    XCTAssertNotNil(viewModel.castsAndCrews.data)
    XCTAssertTrue(viewModel.movie.data!.isFavorit)
    
    viewModel.saveMovie()
    XCTAssertNotNil(viewModel.castsAndCrews.data)
    XCTAssertTrue(viewModel.movie.data!.isFavorit)
  }

}
