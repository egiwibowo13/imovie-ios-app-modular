//
//  HomeView.swift
//  Home
//
//  Created by Egi Wibowo on 22/09/21.
//

import SwiftUI
import CommonUI
import Abstract
import Movie

 struct HomeView: View {
  
  var nav: HomeRoutes
  
  @ObservedObject var homeVM = HomeViewModel(homeUsecase: HomeModule().homeUseCase())
  
  let layout = [
    GridItem(.flexible(minimum: 100)),
    GridItem(.flexible(minimum: 100))
  ]
  
  var options: [ButtonSelectionItem] = [
    ButtonSelectionItem(id: 0, title: "now_showing".localized(identifier: Constants.bundleId)),
    ButtonSelectionItem(id: 1, title: "coming_soon".localized(identifier: Constants.bundleId))
  ]
  
   init(nav: HomeRoutes) {
    self.nav = nav
    UINavigationBar.appearance().barTintColor = .systemBackground
    UINavigationBar.appearance().setBackgroundImage(nil, for: .default)
  }
     var body: some View {
      ScrollView(.vertical) {
        ButtonSelection(data: options, activeId: self.homeVM.activeBtnId) { id in
          self.homeVM.changeActiveBtnId(id: id)
        }
        if homeVM.movies.loading {
          LoadingProgress(2)
        } else if homeVM.movies.isSuccess {
          LazyVGrid(columns: layout) {
            ForEach(self.homeVM.movies.data ?? [], id: \.ids) { movie in
              NavigationLink(
                destination: self.nav.movie(id: movie.id),
                label: {
                    CardMovie(
                      title: movie.title,
                      url: movie.posterUrl,
                      rating: movie.rating,
                      date: movie.releaseDateView
                    ).onAppear {
                      homeVM.loadMoreContentIfNeeded(currentItem: movie)
                    }
                }).buttonStyle(PlainButtonStyle())
              
            }
          }
        }
        if homeVM.loadMoreState.loading {
          LoadingProgress(1)
        }
      }
      .navigationBarBackButtonHidden(true)
      .navigationTitle("iMovie")
      .navigationBarItems(
        trailing: Icon(
          systemName: "person.fill",
          destination: self.nav.account()
        )
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
      HomeView(nav: HomeRoutesSampleImp())
    }
}

extension HomeView {
  func Icon(systemName: String, destination: AnyView) -> some View {
    return NavigationLink(
      destination: destination,
      label: {
        MyIcon(systemName: systemName).foregroundColor(.gray)
      })
  }
  
  func LoadingProgress(_ s: CGFloat) -> some View {
    ProgressView()
      .scaleEffect(s, anchor: .center)
      .progressViewStyle(CircularProgressViewStyle(tint: .primaryColor))
  }
}
