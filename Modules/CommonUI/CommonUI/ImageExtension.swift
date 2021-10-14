//
//  AvatarView.swift
//  CommonUI
//
//  Created by Egi Wibowo on 20/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PictureSizeValue {
  let width: CGFloat?
  let height: CGFloat
}

public struct AnyShape: Shape {
    public var make: (CGRect, inout Path) -> Void

    public init(_ make: @escaping (CGRect, inout Path) -> Void) {
        self.make = make
    }

    public init<S: Shape>(_ shape: S) {
        self.make = { rect, path in
            path = shape.path(in: rect)
        }
    }

    public func path(in rect: CGRect) -> Path {
        return Path { [make] in make(rect, &$0) }
    }
}

public enum PictureType {
  case circle
  case square
  case rectangle
  case potrait
}

public enum PictureSize {
  case xxsmall
  case xsmall
  case small
  case medium
  case large
  case xlarge
}

func mapSizeCircle(size: PictureSize) -> PictureSizeValue {
  switch size {
  case .xxsmall:
    return PictureSizeValue(width: 16, height: 16)
  case .xsmall:
    return PictureSizeValue(width: 24, height: 24)
  case .small:
    return PictureSizeValue(width: 48, height: 48)
  case .medium:
    return PictureSizeValue(width: 60, height: 60)
  case .large:
    return PictureSizeValue(width: 80, height: 80)
  case .xlarge:
    return PictureSizeValue(width: 120, height: 120)
  }
}

func mapSizeSquare(size: PictureSize) -> PictureSizeValue {
  switch size {
  case .xxsmall:
    return PictureSizeValue(width: 16, height: 16)
  case .xsmall:
    return PictureSizeValue(width: 24, height: 24)
  case .small:
    return PictureSizeValue(width: 48, height: 48)
  case .medium:
    return PictureSizeValue(width: 60, height: 60)
  case .large:
    return PictureSizeValue(width: 80, height: 80)
  case .xlarge:
    return PictureSizeValue(width: 120, height: 120)
  }
}

func mapSizeRectangle(size: PictureSize) -> PictureSizeValue {
  switch size {
  case .small:
    return PictureSizeValue(width: 104, height: 72)
  case .medium:
    return PictureSizeValue(width: 164, height: 120)
  default:
    return PictureSizeValue(width: nil, height: 300)
  }
}

func mapShap(type: PictureType) -> AnyShape {
  switch type {
  case .circle:
    return AnyShape(Circle())
  default:
    return AnyShape(RoundedRectangle(cornerRadius: 5))
  }
}

public extension Image {
  
  func picture(type: PictureType, size: PictureSize) -> some View {
    var pcSize = PictureSizeValue(width: 0, height: 0)
    switch type {
    case .circle:
      pcSize = mapSizeCircle(size: size)
    case .square:
      pcSize = mapSizeSquare(size: size)
    case .rectangle:
      pcSize = mapSizeRectangle(size: size)
    case .potrait:
      pcSize = PictureSizeValue(width: 164, height: 250)
    }
    
    let shape = mapShap(type: type)
    
      return self
           .resizable()
           .aspectRatio(contentMode: .fill)
        .frame(width: pcSize.width, height: pcSize.height)
        .clipShape(shape)
   }
}

public extension View {
  func ImageAsync(_ path: String, type: PictureType, size: PictureSize) -> some View {
    
    var pcSize = PictureSizeValue(width: 0, height: 0)
    switch type {
    case .circle:
      pcSize = mapSizeCircle(size: size)
    case .square:
      pcSize = mapSizeSquare(size: size)
    case .rectangle:
      pcSize = mapSizeRectangle(size: size)
    case .potrait:
      pcSize = PictureSizeValue(width: 164, height: 250)
    }
    let shape = mapShap(type: type)
    
    return WebImage(url: URL(string: path))
        .resizable()
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .scaledToFill()
        .frame(width: pcSize.width, height: pcSize.height)
        .clipShape(shape)
  }
}

struct ImageExt: View {
  let url = """
            https://upload.wikimedia.org/wikipedia
            /commons/f/f9/Phoenicopterus_ruber_in_S%C3%A3o_Paulo_Zoo.jpg
            """
    var body: some View {
      VStack {
        Image("Image", bundle: Bundle(identifier: "co.id.egiwibowo.CommonUI")).picture(type: .potrait, size: .small)
        
        ImageAsync(url, type: .potrait, size: .medium)
      }
    }
}

struct ImageExt_Previews: PreviewProvider {
    static var previews: some View {
      ImageExt()
    }
}
