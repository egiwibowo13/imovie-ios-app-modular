//
//  Photos.swift
//  Movie
//
//  Created by Egi Wibowo on 02/10/21.
//

import SwiftUI

struct PhotosView: View {
  var photos: [Photo] = []
  init(photos: [Photo]) {
    self.photos = photos
  }
    var body: some View {
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          ForEach(photos) { photo in
            ImageAsync(photo.url, type: .rectangle, size: .large)
          }
        }
      }
      .padding(.all, 16)
      .frame(alignment: .leading)
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Photos")
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
      PhotosView(photos: [])
    }
}
