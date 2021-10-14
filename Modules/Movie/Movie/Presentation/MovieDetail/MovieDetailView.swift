//
//  MovieDetailView.swift
//  Movie
//
//  Created by Egi Wibowo on 22/09/21.
//

import SwiftUI
import CommonUI

struct MovieDetailView: View {
  
  var nav: MovieDetailRoutes = MovieDetailRoutesImp()
  
  @ObservedObject var movieVM: MovieDetailViewModel
  
  init(movieId: Int, isFavorite: Bool = false) {
    movieVM = MovieDetailViewModel(movieId: movieId, movieUseCase: MovieInjector().provideMovieDetailUseCase())
  }
  
    var body: some View {
      ScrollView(.vertical) {
        VStack(alignment: .center) {
          if movieVM.movie.loading {
            LoadingProgress(2.0).frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          } else if movieVM.movie.isSuccess {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
              BackDropView(url: movieVM.movie.data?.backdropUrl ?? "")
              MovieInfo(movie: self.movieVM.movie.data ?? Movie._default)
                .offset(y: 100)
            }.frame(width: nil, height: 475, alignment: .top)
            SynopsisView(movieVM.movie.data?.description ?? "empty")
              .padding(.vertical, 8)
              .padding(.horizontal, 16)
          } else {
            ErrorViewItem {
              self.movieVM.getMovie()
            }.frame(height: 100, alignment: .top)
          }
          if movieVM.castsAndCrews.loading {
            LoadingProgress(1.0).padding(.vertical, 8)
          } else if movieVM.castsAndCrews.isSuccess {
            CastAndCrewView(data: self.movieVM.getCastCrewsLimit(), allData: self.movieVM.castsAndCrews.data ?? [])
              .padding(.vertical, 8)
              .padding(.horizontal, 16)
          } else {
            ErrorViewItem {
              self.movieVM.getCastAndCrew()
            }.frame( height: 100, alignment: .center)
          }
          if movieVM.photos.loading {
            LoadingProgress(1.0).padding(.vertical, 8)
          } else if movieVM.photos.isSuccess {
            PhotosView(data: self.movieVM.photos.data ?? [])
              .padding(.vertical, 8)
              .padding(.leading, 16)
          } else {
            ErrorViewItem {
              self.movieVM.getPhotos()
            }.frame(height: 100, alignment: .center)
          }
          if movieVM.moviesRecommend.loading {
            LoadingProgress(1.0).padding(.vertical, 8)
          } else if movieVM.moviesRecommend.isSuccess {
            RecommendationsView(data: self.movieVM.moviesRecommend.data ?? [])
              .padding(.vertical, 8)
              .padding(.leading, 16)
          } else {
            ErrorViewItem {
              self.movieVM.getMovieRecommendation()
            }.frame(height: 100, alignment: .center)
          }
        }.padding(.vertical, 16)
      }
      .navigationTitle(movieVM.getTitleText())
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarItems(
        trailing: IconFavorite(isFavorit: self.movieVM.movie.data?.isFavorit ?? false)
        )
    }
}

extension MovieDetailView {
  
  func MovieInfo(movie: Movie) -> some View {
    VStack {
      ImageAsync(movie.posterUrl, type: .potrait, size: .medium)
      Text(movie.title).font(.title3Font).foregroundColor(.black)
      Text("\(movie.releaseDateView) | \(movie.runtimeView)").font(.calloutFont).foregroundColor(.gray)
      Text(movie.genres).font(.calloutFont).foregroundColor(.gray)
      HStack {
        Text("\(movie.rating)/5").font(.bodyFont).foregroundColor(.black)
        Stars(num: movie.rating, size: 20)
      }
    
    }
  }
  
  func ErrorViewItem(action: @escaping () -> Void) -> some View {
    Button(action: { action() }, label: {
      HStack {
        Text("Please Try Again")
        MyIcon(systemName: "arrow.counterclockwise")
      }
    }).buttonStyle(PlainButtonStyle())
  }
  
  func IconFavorite(isFavorit: Bool) -> some View {
    Button(action: {
      self.movieVM.saveMovie()
    }, label: {
      MyIcon(systemName: isFavorit ? "heart.fill": "heart")
        .foregroundColor(.gray)
    })
    .buttonStyle(PlainButtonStyle())
  }
  
  func BackDropView(url: String) -> some View {
    ImageAsync(
      url,
      type: .rectangle,
      size: .large)
      .frame(width: nil, height: 250)
      .clipped()
  }
  
  func SubTitle(_ text: String, destination: AnyView) -> some View {
    HStack {
      Text(text).font(.headlineFont).foregroundColor(.black)
      Spacer()
      NavigationLink(
        destination: destination,
        label: {
          Text("View All").font(.subheadline2Font)
        })
    }
  }
  
  func SynopsisView(_ description: String) -> some View {
    VStack(alignment: .leading) {
      Text("Synopsis").font(.headlineFont).foregroundColor(.black)
      Text(description).font(.captionFont).foregroundColor(.black)
    }.frame(alignment: .leading)
  }
  
  func CastAndCrewView(data: [CastAndCrew], allData: [CastAndCrew]) -> some View {
    VStack {
      SubTitle("Cast And Crew", destination: nav.castAndCrew(castsAndCrews: allData))
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          ForEach(data) { cast in
            CastItemView(name: cast.name, character: cast.character, url: cast
                          .profileUrl)
          }
        }
      }.frame(alignment: .leading)
    }
  }
  
  func PhotosView(data: [Photo]) -> some View {
    VStack {
      SubTitle("Photos", destination: nav.photos(photos: data)).padding(.trailing, 16)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(data) { photo in
            ImageAsync(photo.url, type: .rectangle, size: .small)
          }
        }
      }.frame(alignment: .leading)
    }
  }
  
  func RecommendationsView(data: [Movie]) -> some View {
    VStack {
      SubTitle("Recommendations", destination: nav.recomendation(movieId: self.movieVM.movieId)).padding(.trailing, 16)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(data) { movie in
            NavigationLink(
              destination: nav.movieDetail(movieId: movie.id),
              label: {
                ImageAsync(movie.posterUrl, type: .rectangle, size: .medium)
              })
          }
        }
      }.frame(alignment: .leading)
    }
  }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieId: 1)
    }
}
