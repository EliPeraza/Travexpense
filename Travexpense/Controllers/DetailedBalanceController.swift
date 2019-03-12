//
//  DetailedBalanceController.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/28/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class DetailedBalanceController: UIViewController {

  
  @IBOutlet weak var overallBalance: UITableView!
  
  
  var expensesDataFromDataBase = [ExpenseModel]() {
    didSet {
      DispatchQueue.main.async {
        self.overallBalance.reloadData()
        
      }
    }
  }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      overallBalance.delegate = self
      overallBalance.dataSource = self
      
      getDataFromFireBase()

    }
  
  private func getDataFromFireBase() {
    DatabaseManager.firebaseBD.collection(DatabaseKeys.expenses).addSnapshotListener(includeMetadataChanges: true) { (snapShot, error) in
      if let error = error {
        self.showAlert(title: "Network Error", message: error.localizedDescription, actionTitle: "Ok")
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

extension DetailedBalanceController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DatabaseManager.expensesWeGetFromFireBase.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = overallBalance.dequeueReusableCell(withIdentifier: "DetailedCell", for: indexPath)
    
    let currentExpense = expensesDataFromDataBase[indexPath.row]
    
    cell.textLabel?.text = currentExpense.expenseDescription
//    cell.detailTextLabel?.text = String(currentExpense.expenseAmount)
    
    return cell
  }


}
