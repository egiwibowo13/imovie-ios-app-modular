//
//  CardMovie.swift
//  CommonUI
//
//  Created by Egi Wibowo on 21/09/21.
//

import SwiftUI

public struct CardPhoto: View {
  var url: String
  var size: PictureSize
  public init(url: String, size: PictureSize) {
    self.url = url
    self.size = size
  }
  public var body: some View {
    ImageAsync(url, type: .rectangle, size: size)
  }
}

public struct CardMovie: View {
  
  var title: String
  var url: String
  var rating: Int
  var date: String
  
  public init(title: String, url: String, rating: Int, date: String) {
    self.title = title
    self.url = url
    self.rating = rating
    self.date = date
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ImageAsync(url, type: .potrait, size: .medium)
      Stars(num: rating).padding(.top, 4)
      Text(title).font(.subheadlineFont).lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
      HStack(spacing: 2) {
        Image(systemName: "calendar")
          .resizable()
          .frame(width: 14, height: 14, alignment: .center).padding(.horizontal, 2)
        Text(date).font(.caption)
      }
      Spacer()
    }.frame(width: 164, alignment: .center)
  }
  
}

let sampleUrl = """
              https://upload.wikimedia.org/wikipedia
              /commons/f/f9/Phoenicopterus_ruber_in_S%C3%A3o_Paulo_Zoo.jpg
              """

struct CardMovie_Previews: PreviewProvider {
    static var previews: some View {
      VStack {
        CardMovie(title: "Spiderman", url: sampleUrl, rating: 5, date: "12 Desc 2010")
        CardPhoto(url: sampleUrl, size: .small)
        CardPhoto(url: sampleUrl, size: .large)
      }
    }
}
