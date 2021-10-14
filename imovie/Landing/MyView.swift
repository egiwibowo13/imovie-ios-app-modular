//
//  MyView.swift
//  imovie
//
//  Created by Egi Wibowo on 01/10/21.
//

import Foundation
import SwiftUI

extension Font {
    static func avenirNext(size: Int) -> Font {
        return Font.custom("Avenir Next", size: CGFloat(size))
    }
    
    static func avenirNextRegular(size: Int) -> Font {
        return Font.custom("AvenirNext-Regular", size: CGFloat(size))
    }
}

struct MyView: View {
    @ObservedObject private var articleContent: ViewFrame = ViewFrame()
    @State private var titleRect: CGRect = .zero
    @State private var headerImageRect: CGRect = .zero
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var imageHeaderCover = ImageCoverSetup()
  
  init() {
//    UINavigationBar.appearance().barTintColor = .clear
//    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
  }
    
    // 1
    private func getHeaderTitleOffset() -> CGFloat {
        let currentYPos = titleRect.midY
        if currentYPos < headerImageRect.maxY {
            let minYValue: CGFloat = 50.0
          let maxYValue: CGFloat = imageHeaderCover.collapsedImageHeight
            let currentYValue = currentYPos

            let percentage = max(-1, (currentYValue - maxYValue) / (maxYValue - minYValue))
            let finalOffset: CGFloat = -40.0

            return 20 - (percentage * finalOffset)
        }

        return .infinity
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image("person")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                        
                        VStack(alignment: .leading) {
                            Text("Article Written By")
                                .font(.avenirNext(size: 12))
                                .foregroundColor(.gray)
                            Text("Brandon Baars")
                                .font(.avenirNext(size: 17))
                        }
                    }
                    
                    Text("02 January 2019 • 5 min read")
                        .font(.avenirNextRegular(size: 12))
                        .foregroundColor(.gray)
                    
                    Text("How to build a parallax scroll view")
                        .font(.avenirNext(size: 28))
                        .background(GeometryGetter(rect: self.$titleRect)) // 2
                    
                    Text(loremIpsum)
                        .lineLimit(nil)
                        .font(.avenirNextRegular(size: 17))
                }
                .padding(.horizontal)
                .padding(.top, 16.0)
            }
            .offset(y: imageHeaderCover.imageHeight + 16)
            .background(GeometryGetter(rect: $articleContent.frame))
            
            GeometryReader { geometry in
                // 3
                ZStack(alignment: .bottom) {
                    Image("background_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: imageHeaderCover.getHeightForHeaderImage(geometry))
                        .blur(radius: imageHeaderCover.getBlurRadiusForImage(geometry))
                        .clipped()
                        .background(GeometryGetter(rect: self.$headerImageRect))
                    // 4
                  HStack {
                    Text("How to build a parallax scroll view aaa sss aasd")
                      .frame(width: geometry.size.width - 100)
                      .lineLimit(1)
                        .font(.avenirNext(size: 17))
                        .foregroundColor(.white)
                    
                  }
                  .padding(.horizontal, 16)
                  .offset(x: 0, y: self.getHeaderTitleOffset())
                }
                .clipped()
                .offset(x: 0, y: imageHeaderCover.getOffsetForHeaderImage(geometry))
            }.frame(height: imageHeaderCover.imageHeight)
            .offset(x: 0, y: -(articleContent.startingRect?.maxY ?? UIScreen.main.bounds.height))
        }.edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
          Button(action: {
            presentationMode.wrappedValue.dismiss()
          }, label: {
            Image(systemName: "arrow.left").foregroundColor(.white)
          })
        })
        .navigationBarItems(leading: Button(action: {
          presentationMode.wrappedValue.dismiss()
        }, label: {
          Image(systemName: "arrow.left").foregroundColor(.white)
        }), trailing: Button(action: {
          presentationMode.wrappedValue.dismiss()
        }, label: {
          Image(systemName: "heart").foregroundColor(.white)
        }))
        .onAppear {
              UINavigationBar.appearance().barTintColor = .clear
              UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        }
        .onDisappear {
          UINavigationBar.appearance().barTintColor = .systemBackground
          UINavigationBar.appearance().setBackgroundImage(nil, for: .default)
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let loremIpsum = """
Lorem ipsum dolor sit amet consectetur adipiscing elit donec, gravida commodo hac non mattis augue duis vitae inceptos,
laoreet taciti at vehicula cum arcu dictum. Cras netus vivamus sociis pulvinar est erat,
quisque imperdiet velit a justo maecenas, pretium gravida ut himenaeos nam.
Tellus quis libero sociis class nec hendrerit,
id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.
Sagittis vivamus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus,
iaculis vestibulum viverra nisl ullamcorper lectus curabitur himenaeos dictumst malesuada tempor,
cras maecenas enim est eu turpis hac sociosqu tellus magnis.
Sociosqu varius feugiat volutpat justo fames magna malesuada,
amus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus,
iaculis vestibulum viverra nisl ullamcorper lectus curabitur himenaeos dictumst malesuada tempor,
cras maecenas enim est eu turpis hac sociosqu tellus magnis.
Sociosqu varius feugiat volutpat justo fames magna malesuada,
"""

class ViewFrame: ObservableObject {
    var startingRect: CGRect?
    
    @Published var frame: CGRect {
        willSet {
            if startingRect == nil {
                startingRect = newValue
            }
        }
    }
    
    init() {
        self.frame = .zero
    }
}

struct GeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            AnyView(Color.clear)
                .preference(key: RectanglePreferenceKey.self, value: geometry.frame(in: .global))
        }.onPreferenceChange(RectanglePreferenceKey.self) { (value) in
            self.rect = value
        }
    }
}

struct RectanglePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct ImageCoverSetup {
  
  let imageHeight: CGFloat = 300
  let collapsedImageHeight: CGFloat = 75
  
  func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
       geometry.frame(in: .global).minY
   }
  
  func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
      let offset = getScrollOffset(geometry)
    let sizeOffScreen = imageHeight - collapsedImageHeight
    
      if offset < -sizeOffScreen {
          let imageOffset = abs(min(-sizeOffScreen, offset))
          return imageOffset - sizeOffScreen
      }
      if offset > 0 {
          return -offset
      }
      return 0
  }
  
  func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
      let offset = getScrollOffset(geometry)
      let imageHeight = geometry.size.height
      
      if offset > 0 {
          return imageHeight + offset
      }
      
      return imageHeight
  }

  func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
      let offset = geometry.frame(in: .global).maxY
      
      let height = geometry.size.height
      let blur = (height - max(offset, 0)) / height
      
      return blur * 6
  }
}

extension UINavigationBar {
    func transparentNavigationBar() {
    self.setBackgroundImage(UIImage(), for: .default)
    self.shadowImage = UIImage()
    self.isTranslucent = true
    }
}
