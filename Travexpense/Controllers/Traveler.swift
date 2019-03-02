//
//  TravelerModel.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/1/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

//This info I'll get from my DataBase under user
class Traveler {
  
  let travelerName: String
  
  var isTravelerSelected = false
  
  init(travelerName: String) {
    self.travelerName = travelerName
  }
  
}

struct SelectedTravelers {
  
 var travelers = [Traveler.init(travelerName: "Oli"),
                        Traveler.init(travelerName: "Aaron"),
                        Traveler.init(travelerName: "Pritesh"),
                        Traveler.init(travelerName: "Jeff")]
  
  var selectedTravelers: [Traveler] {
    return travelers.filter{return $0.isTravelerSelected}
  }
  
  
}
