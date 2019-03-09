//
//  LogicModel.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/6/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation
import UIKit

struct LogicModel {
  
  public func splitAmount(totalAMount: Double, peopleSplittingTheBill: [String]) -> [String : Double] {
    var amountToReturn = [String : Double]()
    
    let x = totalAMount / Double(peopleSplittingTheBill.count)
    
    for user in peopleSplittingTheBill {
      amountToReturn[user] =  x
    }
    
    return amountToReturn
  }
  
  
}



