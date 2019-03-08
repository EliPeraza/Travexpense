//
//  DataManager.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class DatabaseManager {
  
  static var expensesWeGetFromFireBase = [ExpenseModel]()
  
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
    ref = firebaseBD.collection("expenses").addDocument(data: [/*"expenseID" : expense.expenseID*/
      "userID" : expense.userID,
                                                               "expenseCategory" :expense.expenseCategory,
                                                               "expenseDescription" : expense.expenseDescription,
                                                               "expenseAmount" : expense.expenseAmount,
                                                               "travelersSharingExpense" : expense.travelersSharingExpense],
                                                    
                                                        completion: {(error) in
                                                          if let error = error {
                                                            print("could not post expense. Error: \(error)")
                                                            
                                                          } else {
                                                            print("expense saved at ref: \(ref?.documentID ?? "no doc id")")
                                                            DatabaseManager.firebaseBD.collection(DatabaseKeys.expenses)
                                                              .document(ref!.documentID)
                                                              .updateData(["expenseID" : ref!.documentID], completion: { (error) in
                                                                if let error = error {
                                                                  print("error updating field \(error)")
                                                                } else {
                                                                  print("field updated")
                                                                }
                                                              })
                                                          }
    })
  }
  
  static func getExpense(completion: @escaping (([ExpenseModel])) -> [ExpenseModel]) {
    var finalArrayFromFirebase = [ExpenseModel]()
    firebaseBD.collection("expenses").addSnapshotListener { (snapshot, error) in
      if let snapshot = snapshot {
        for document in snapshot.documents {
          let receivedExpenses = ExpenseModel.init(dictionaryFromFirebase: document.data())
          finalArrayFromFirebase.append(receivedExpenses)
          print("found \(finalArrayFromFirebase.count) expenses")

        }
        expensesWeGetFromFireBase = completion(finalArrayFromFirebase)
        print("this is the number of expenses I get in database manager expensesweget \(expensesWeGetFromFireBase.count)")
      } else if let error = error {
        print("error getting info from firebase\(error.localizedDescription)")

      }
    }
  }
  
  
  
}


/*TODO: Properties like arrays - persistence
 methods to manipoulate data
 */
