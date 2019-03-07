//
//  DetailedBalanceController.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/28/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class DetailedBalanceController: UIViewController {

  var expensesDataFromDataBase = [ExpenseModel]() {
    didSet {
      DispatchQueue.main.async {
        
      }
    }
  }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      
      getDataFromFireBase()

    }
  
  private func getDataFromFireBase() {
    DatabaseManager.firebaseBD.collection(DatabaseKeys.expenses).addSnapshotListener(includeMetadataChanges: true) { (snapShot, error) in
      if let error = error {
        self.showAlert(title: "Network Error", message: error.localizedDescription)
      } else if let snapShot = snapShot {
        var expenses = [ExpenseModel]()
        for document in snapShot.documents {
          let expense = ExpenseModel(dictionaryFromFirebase: document.data())
          print(document.data())
          expenses.append(expense)
        }
        self.expensesDataFromDataBase = expenses
        print("found \(expenses.count) expenses")
      }
    }
  }

}

//extension DetailedBalanceController: UITableViewDataSource, UITableViewDelegate {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    <#code#>
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    <#code#>
//  }
//
//
//}
