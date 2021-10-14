//
//  Typography.swift
//  CommonUI
//
//  Created by Egi Wibowo on 20/09/21.
//

import SwiftUI

extension Font {
  
  public static var largeTitleFont: Font {
    return Font.custom("Nunito-Black", size: 34)
  }
  
  public static var titleFont: Font {
    return Font.custom("Nunito-Black", size: 28)
  }
  public static var title2Font: Font {
      return Font.custom("Nunito-Black", size: 22)
  }
  public static var title3Font: Font {
      return Font.custom("Nunito-Black", size: 20)
  }
  public static var headlineFont: Font {
      return Font.custom("Nunito-Black", size: 17)
  }
  public static var bodyFont: Font {
      return Font.custom("Nunito-Regular", size: 17)
  }
  public static var calloutFont: Font {
      return Font.custom("Nunito-Regular", size: 16)
  }
  public static var subheadlineFont: Font {
      return Font.custom("Nunito-Bold", size: 15)
  }
  public static var subheadline2Font: Font {
      return Font.custom("Nunito-Black", size: 13)
  }
  public static var footnoteFont: Font {
      return Font.custom("Nunito-Regular", size: 13)
  }
  public static var captionFont: Font {
      return Font.custom("Nunito-Regular", size: 12)
  }
  public static var caption2Font: Font {
      return Font.custom("Nunito-Regular", size: 11)
  }
}

struct Typography: View {
    var body: some View {
      VStack {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).font(.titleFont)
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).font(.footnote)
      }
    }
}

struct Typography_Previews: PreviewProvider {
    static var previews: some View {
        Typography()
    }
}
