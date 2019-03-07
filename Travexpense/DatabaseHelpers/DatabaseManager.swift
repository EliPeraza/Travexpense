//
//  DataManager.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
  private init() {}

  static let firebaseBD: Firestore = {
    let db = Firestore.firestore()
    let setting = db.settings
    //    setting.areTimestampsInSnapshotsEnabled = true
    db.settings = setting
    return db
  }()

  static func postExpense(expense: ExpenseModel) {
    var ref: DocumentReference? = nil
    ref = firebaseBD.collection("expenses").addDocument(data: ["expenseCategory" : expense.expenseCategory, "expenseDescription" : expense.expenseDescription, "expenseAmount" : expense.expenseAmount, "travelersSharingExpense" : expense.travelersSharingExpense], completion: {(error) in
      if let error = error {
        print("could not post expense. Error: \(error)")                                  } else {
        print("expense saved at ref: \(ref?.documentID ?? "no doc id")")                                  }
    })
  }

  static func getExpense(completion: @escaping (([ExpenseModel])) -> Void) {
    var finalArrayFromFirebase = [ExpenseModel]()
    firebaseBD.collection("expenses").addSnapshotListener { (snapshot, error) in
      if let snapshot = snapshot {
        for document in snapshot.documents {
          let receivedExpenses = ExpenseModel.init(dictionaryFromFirebase: document.data())
          finalArrayFromFirebase.append(receivedExpenses)
          print("found \(finalArrayFromFirebase.count) expenses")

        }
        completion(finalArrayFromFirebase)
      } else if let error = error {
        print("error getting info from firebase\(error.localizedDescription)")
      }
    }
  }
}
