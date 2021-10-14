//
//  FavoriteViewModelTests.swift
//  FavoriteTests
//
//  Created by Egi Wibowo on 14/10/21.
//

import XCTest
@testable import Favorite

class FavoriteViewModelTests: XCTestCase {

  var viewModel: FavoriteMoviesViewModel!
  var mockFavoriteUseCase: MockFavoriteUseCase!

  override func setUp() {
    mockFavoriteUseCase = MockFavoriteUseCase()
    viewModel = .init(favoriteUseCase: mockFavoriteUseCase)
  }
  
  func test_getFavoriteMoviesSuccess() {
    let expectedFavorite = Movie.getMockMovies(num: 10)
    mockFavoriteUseCase.getMoviesResult = .success(expectedFavorite)
    
    viewModel.getFavoriteMovies()
    
    XCTAssertEqual(expectedFavorite.count, viewModel.movies.count)
  }

}
