//
//  AccountView.swift
//  Account
//
//  Created by Egi Wibowo on 11/10/21.
//

import SwiftUI

struct AccountView: View {
  var nav: AccountRoutes
  
  init(nav: AccountRoutes) {
    self.nav = nav
  }
    var body: some View {
      VStack(alignment: .center, spacing: 16) {
        Profile().padding(.vertical, 16)
        SocialMedia().padding(.vertical, 16)
        MenuItem("heart", title: "Favorite Movie", destination: self.nav.favoriteMovies()).padding(.vertical, 16)
        Spacer()
      }
      .padding(.vertical, 16)
      .frame(alignment: .top)
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Profile")
    }
}

extension AccountView {
  func MenuItem(_ imgName: String, title: String, destination: AnyView) -> some View {
    NavigationLink(
      destination: destination,
      label: {
        HStack {
          Image(systemName: imgName).foregroundColor(.gray)
          Text(title).foregroundColor(.gray).font(.calloutFont)
        }
        .frame(width: UIScreen.main.bounds.width - 64, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.gray, lineWidth: 1)
        )
      })
  }
  
  func Profile() -> some View {
    VStack {
      Image("profile", bundle: Constants.bundle).picture(type: .circle, size: .xlarge)
      Text("Egi Ari Wibowo").font(.titleFont)
      Text("egiwibowo13@gmail.com").font(.calloutFont).foregroundColor(.gray)
    }
  }
  
  func SocialMedia() -> some View {
    HStack {
      Spacer()
      SocialMediaIcon("linkedin", account: "egi-ari-wibowo")
      Spacer()
      Divider()
      Spacer()
      SocialMediaIcon("github", account: "egiwibwo13")
      Spacer()
    }
    .frame(height: 100)
  }
  
  func SocialMediaIcon(_ image: String, account: String) -> some View {
    VStack {
      Image(image, bundle: Constants.bundle)
      Text(account).font(.calloutFont).foregroundColor(.gray)
    }
  }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(nav: AccountSampleRoutes())
    }
}
