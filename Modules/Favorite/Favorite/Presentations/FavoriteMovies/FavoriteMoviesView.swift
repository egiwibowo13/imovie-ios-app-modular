//
//  FavoriteMoviesView.swift
//  Favorite
//
//  Created by Egi Wibowo on 11/10/21.
//

import SwiftUI
import CommonUI

struct FavoriteMoviesView: View {
  
  var nav: FavoriteMoviesRoutes
  
  @ObservedObject var favoriteVM = FavoriteMoviesViewModel(favoriteUseCase: Injector().provideFavoriteUseCase())
  
  init(nav: FavoriteMoviesRoutes) {
    self.nav = nav
  }
  
  let layout = [
    GridItem(.flexible(minimum: 100)),
    GridItem(.flexible(minimum: 100))
  ]
  
    var body: some View {
      ScrollView(.vertical) {
        if self.favoriteVM.movies.count > 0 {
          ListMovie(
            data: self.favoriteVM.movies) { id in
            self.nav.movie(id: id)
          }
        } else {
          EmptyFAvoriteMoview()
        }
      }.navigationTitle("Favorite")
      .navigationBarTitleDisplayMode(.inline)
    }
}

extension FavoriteMoviesView {
  func EmptyFAvoriteMoview() -> some View {
    VStack(spacing: 16) {
      Image("empty-box", bundle: Constants.bundle).picture(type: .square, size: .xlarge)
      Text("Favorite is empty")
    }.padding(.top, 16)
  }
  
  func ListMovie(data: [Movie], destination: @escaping (_ movieId: Int) -> AnyView) -> some View {
    LazyVGrid(columns: layout) {
      ForEach(data, id: \.id) { movie in
        NavigationLink(
          destination: destination(movie.id),
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
  }
}

struct FavoriteMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesView(nav: FavoriteMoviesSampleRoutes())
    }
}
