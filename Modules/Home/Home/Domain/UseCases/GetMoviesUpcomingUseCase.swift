//
//  GetMoviesUpcomingUseCase.swift
//  Home
//
//  Created by Egi Wibowo on 04/10/21.
//

import Foundation
import Combine
import Abstract

public class GetMoviesUpcomingUseCase {
    
    private let repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func execute(request: MoviesRequestDTO) -> AnyPublisher<MoviesPage, APIError> {
      return self.repository.getMoviesUpcoming(request: request).eraseToAnyPublisher()
    }
}
