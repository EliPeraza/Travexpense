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

  
  
  
}


//
//  func getData() -> [ExpenseModel]{
//    var arrayToReturn = [ExpenseModel]()
//    DatabaseManager.firebaseBD.collection(DatabaseKeys.expenses).addSnapshotListener(includeMetadataChanges: true) { (snapShot, error) in
//      if let error = error {
//        print(error.localizedDescription)
//      } else if let snapShot = snapShot {
//        var expenses = [ExpenseModel]()
//        for document in snapShot.documents {
//          let expense = ExpenseModel(dictionaryFromFirebase: document.data())
//          print(document.data())
//          expenses.append(expense)
//        }
//        arrayToReturn = expenses
//        print("found \(expenses.count) expenses")
//      }
//    }
//    return arrayToReturn
//  }
//
