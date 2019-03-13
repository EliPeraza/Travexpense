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
  let userName: String?
  
  init(dict: [String: Any]) {
    self.userID = dict["userID"] as? String ?? "no user ID"
    self.email = dict["email"] as? String ?? "no email found"
    self.displayName = dict["displayName"] as? String ?? "no display name entered"
    self.imageURL = dict["imageURL"] as? String ?? "no imageURL"
    self.userName = dict["userName"] as? String ?? "no username"
  }
}

class TravelerInfo {
  private var ArrayOfTravelersNames: TEUser
  
  var isSelected = false
  
  var title: String {
    return ArrayOfTravelersNames.email
  }
  
  init(item: TEUser) {
    self.ArrayOfTravelersNames = item
  }
}

class TravelerModel {
  static var usersFromDataBase = [TEUser]()

  var travelerInfo = [TravelerInfo]()
  
  var selectedItems: [TravelerInfo] {
    return travelerInfo.filter{return $0.isSelected}
  }
  
  init() {
    travelerInfo = TravelerModel.usersFromDataBase.map {TravelerInfo(item: $0)}
  }
  
}







