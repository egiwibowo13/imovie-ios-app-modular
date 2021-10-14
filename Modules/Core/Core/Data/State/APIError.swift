//
//  APIError.swift
//  Core
//
//  Created by Egi Wibowo on 03/10/21.
//

import Foundation

public enum APIError: Error {
    case unknown
    case dataNotFound
    case requestFailed
    case invalidInstance
    case message(reason: String), parseError(message: String), networkError(message: String), error(message: String)

//    let code: Int
//    let message: String
}

//enum APIError: Error {
//    case requestFailed
//    case jsonConversionFailure
//    case invalidData
//    case responseUnsuccessful
//    case jsonParsingFailure
//    case dataNotFound
//    case invalidInstance
//    case error(message: String)
//    var localizedDescription: String {
//        switch self {
//        case .requestFailed: return "Request Failed"
//        case .invalidData: return "Invalid Data"
//        case .responseUnsuccessful: return "Response Unsuccessful"
//        case .jsonParsingFailure: return "JSON Parsing Failure"
//        case .jsonConversionFailure: return "JSON Conversion Failure"
//        case .dataNotFound: return "Data Not Found"
//        case .invalidInstance: return "Invalid Instance"
//        case .error(let message) return message
//        }
//    }
//}
