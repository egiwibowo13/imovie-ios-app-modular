//
//  Date.swift
//  Core
//
//  Created by Egi Wibowo on 13/10/21.
//

import Foundation

func dateFormater(format: String) -> DateFormatter {
  let formatter = DateFormatter()
  formatter.dateFormat = format
  formatter.calendar = Calendar(identifier: .iso8601)
  formatter.timeZone = TimeZone(secondsFromGMT: 0)
  formatter.locale = Locale(identifier: "en_US_POSIX")
  return formatter
}

public extension Date {
  func toString(format: String) -> String {
    dateFormater(format: format).string(from: self)
  }
}

public extension String {
  func toDate(format: String) -> Date? {
    dateFormater(format: format).date(from: self)
  }
}

public extension Int {
  
  func toDouble() -> Double {
    return Double(self)
  }
  
  func convertMinuteToSeconds() -> Int {
    return self * 60
  }
  
  func convertMinutesToRunTimes(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    return formatter.string(from: self.convertMinuteToSeconds().toDouble()) ?? ""
  }
}
