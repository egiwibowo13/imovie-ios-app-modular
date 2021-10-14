//
//  MoviesRecommendationView.swift
//  Movie
//
//  Created by Egi Wibowo on 07/10/21.
//

import SwiftUI
import CommonUI

struct MoviesRecommendationView: View {
  @ObservedObject var moviesRecommendVM: MoviesRecommendViewModel
  
  var nav: MoviesRecommendRoutes = MoviesRecommendRoutesImp()
  
  let layout = [
    GridItem(.flexible(minimum: 100)),
    GridItem(.flexible(minimum: 100))
  ]
  init(movieId: Int) {
    moviesRecommendVM = MoviesRecommendViewModel(
      movieId: movieId,
      movieUseCase: MovieInjector().provideMovieDetailUseCase()
    )
  }
    var body: some View {
      ScrollView(.vertical, showsIndicators: false) {
        LazyVGrid(columns: layout) {
          ForEach(self.moviesRecommendVM.moviesRecommend, id: \.id) { movie in
            NavigationLink(
              destination: nav.movieDetail(movieId: movie.id),
              label: {
                CardMovie(
                  title: movie.title,
                  url: movie.posterUrl,
                  rating: movie.rating,
                  date: movie.releaseDateView
                )
              }).buttonStyle(PlainButtonStyle())
          }
        }
        
      }.frame(alignment: .leading)
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Recommendation")
    }
}

struct MoviesRecommendationView_Previews: PreviewProvider {
    static var previews: some View {
      MoviesRecommendationView(movieId: 1)
    }
}
