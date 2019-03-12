//
//  TravelerModel.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/1/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation


//This info I'll get from my DataBase under user

struct Traveler {
  let travelerName: String
}

class TravelerInfo {
  private var ArrayOfTravelersNames: Traveler
  
  var isSelected = false
  
  var title: String {
    return ArrayOfTravelersNames.travelerName
  }
  
  init(item: Traveler) {
    self.ArrayOfTravelersNames = item
  }
}

class TravelerModel {
  var travelerInfo = [TravelerInfo]()
  
  var selectedItems: [TravelerInfo] {
    return travelerInfo.filter{return $0.isSelected}
  }
  
  
  let dataArray = [Traveler(travelerName: "Oli"),
                   Traveler(travelerName: "Aaron"),
                   Traveler(travelerName: "Jeff"),
                   Traveler(travelerName: "Pritesh")]
  
  init() {
    travelerInfo = dataArray.map {TravelerInfo(item: $0)}
  }
  
}






