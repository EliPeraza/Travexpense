//
//  TEUser.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/7/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation


struct TEUser {
  let username: String?
  let imageURL: String?
  
  init(dict: [String: Any]) {
    self.username = dict["username"] as? String ?? "no username"
    self.imageURL = dict["imageURL"] as? String ?? "no imageURL"
  }
}
