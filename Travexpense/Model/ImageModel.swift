//
//  ImageModel.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/6/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

struct ImageModel: Codable {
  let hits: [ImageDetailedInfo]
}

struct ImageDetailedInfo: Codable {
  let largeImageURL: String //URL
  let id: Int
}
