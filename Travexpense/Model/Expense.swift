//
//  Expense.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation


struct ExpenseModel: Codable {
  let expenseCategory: String
  let expenseSubcategory: String
  let expenseDescription: String
  let expenseAmount: Double
  var travelersSharingExpense: [String:String]
  
  
  // initializer to post in Firebase
  init( expenseCategory: String, expenseSubcategory: String, expenseDescription: String, expenseAmount: Double, travelersSharingExpense: [String:String]){
    self.expenseCategory = expenseCategory
    self.expenseSubcategory = expenseSubcategory
    self.expenseDescription = expenseDescription
    self.expenseAmount = expenseAmount
    self.travelersSharingExpense = travelersSharingExpense
  }
  
  //initializer to get data from firebase
  init(dictionaryFromFirebase: [String : Any]) {
    self.expenseCategory = dictionaryFromFirebase["expenseCategory"] as? String ?? "didn't find a category expense"
    self.expenseSubcategory = dictionaryFromFirebase["expenseSubcategory"] as? String ?? "no sub-category selected"
    self.expenseDescription = dictionaryFromFirebase["expenseDescription"] as? String ?? "didn't find description for expense"
    self.expenseAmount = dictionaryFromFirebase["expenseAmount"] as? Double ?? 0.0
    self.travelersSharingExpense = dictionaryFromFirebase["travelersSharingExpense"] as? [String : String] ?? ["No travelers were selected to share expense" : "None"]
    
  }
  
}

