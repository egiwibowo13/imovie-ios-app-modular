//
//  DevResponse.swift
//  Dev
//
//  Created by Egi Wibowo on 30/12/21.
//

import Foundation

public struct DevResponse<T: Decodable>: Decodable {
  let success: Bool?
  let code: Int?
  let message: String?
  let data: T?
}
