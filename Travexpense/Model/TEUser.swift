//
//  TEUser.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/7/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation


struct TEUser {
  let userID: String
  let email: String
  let displayName: String
  let imageURL: String?
  let username: String?
  
  init(dict: [String: Any]) {
    self.userID = dict["userID"] as? String ?? "no user ID"
    self.email = dict["email"] as? String ?? "no email found"
    self.displayName = dict["displayName"] as? String ?? "no display name entered"
    self.imageURL = dict["imageURL"] as? String ?? "no imageURL"
    self.username = dict["username"] as? String ?? "no username"
    
  }
}
