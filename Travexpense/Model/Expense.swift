//
//  Expense.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation


struct ExpenseModel: Codable {
  let userID: String
//  let expenseID: String
  let expenseCategory: String
  let expenseDescription: String
  let expenseAmount: Double
  var travelersSharingExpense: [String:String]
  var splittedAmountDictionary: [String : Double]
  
  
  // initializer to post in Firebase
  init( userID: String, /*expenseID: String*/ expenseCategory: String, expenseDescription: String, expenseAmount: Double, travelersSharingExpense: [String:String], splittedAmountDictionary: [String : Double]){
    self.userID = userID
//    self.expenseID = expenseID
    self.expenseCategory = expenseCategory
    self.expenseDescription = expenseDescription
    self.expenseAmount = expenseAmount
    self.travelersSharingExpense = travelersSharingExpense
    self.splittedAmountDictionary = splittedAmountDictionary
  }
  
  //initializer to get data from firebase
  init(dictionaryFromFirebase: [String : Any]) {
    self.userID = dictionaryFromFirebase["userID"] as? String ?? "didn't find user ID"
//    self.expenseID = dictionaryFromFirebase["expenseID"] as? String ?? "didn't find an expense ID"
    self.expenseCategory = dictionaryFromFirebase["expenseCategory"] as? String ?? "didn't find a category expense"
    self.expenseDescription = dictionaryFromFirebase["expenseDescription"] as? String ?? "didn't find description for expense"
    self.expenseAmount = dictionaryFromFirebase["expenseAmount"] as? Double ?? 0.0
    self.travelersSharingExpense = dictionaryFromFirebase["travelersSharingExpense"] as? [String : String] ?? ["No travelers were selected to share expense" : "None"]
    self.splittedAmountDictionary = dictionaryFromFirebase["splittedAmountDictionary"] as? [String : Double] ?? ["No split amount found" : 0.0]
    
  }
  
}

