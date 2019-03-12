//
//  Date+Extension.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/12/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

extension Date {
  // get an ISO timestamp
  static func getISOTimestamp() -> String {
    let isoDateFormatter = ISO8601DateFormatter()
    let timestamp = isoDateFormatter.string(from: Date())
    return timestamp
  }
}
