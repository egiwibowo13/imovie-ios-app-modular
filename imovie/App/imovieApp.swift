//
//  imovieApp.swift
//  imovie
//
//  Created by Egi Wibowo on 20/09/21.
//

import SwiftUI
import CommonUI
import Movie
import Home

@main
struct ImovieApp: App {

  init() {
    UIFont.loadFonts()
  }
    var body: some Scene {
        WindowGroup {
          ContentView()
        }
    }
}

struct ImovieApp_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension UIFont {
  private static func registerFont(withName name: String, fileExtension: String) {
    let frameworkBundle = Bundle(identifier: "co.id.egiwibowo.CommonUI")!
    let pathForResourceString = frameworkBundle.path(forResource: name, ofType: fileExtension)
    let fontData = NSData(contentsOfFile: pathForResourceString!)
    let dataProvider = CGDataProvider(data: fontData!)
    let fontRef = CGFont(dataProvider!)
    var errorRef: Unmanaged<CFError>?

    if CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) == false {
      print("Error registering font")
    }
  }

  public static func loadFonts() {
    registerFont(withName: "Nunito-Black", fileExtension: "ttf")
    registerFont(withName: "Nunito-Bold", fileExtension: "ttf")
    registerFont(withName: "Nunito-Light", fileExtension: "ttf")
    registerFont(withName: "Nunito-Regular", fileExtension: "ttf")
  }
}
