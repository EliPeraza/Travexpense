//
//  EnterExpenseController.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/28/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class EnterExpenseController: UIViewController {
  
  //Var to save object to Firebase
  var expenseCategory = String()
  
  
  private var amountTextFieldPlaceholder = "Enter total amount for the expense"
  private var expenseDescriptionPlaceHolder = "Enter expense description. Example: 'Train to Paris'"

  var travelerModel = TravelerModel()
  
  @IBOutlet var arrayOfExpenseCategoryButton: [UIButton]!
  
  @IBOutlet weak var expenseCategoryButton: UIButton! 
  
  @IBOutlet weak var amountTextField: UITextField!
  
  @IBOutlet weak var expenseDescriptionField: UITextField!
  
  @IBOutlet weak var tableToSelectTravelers: UITableView!
  
  
  @IBOutlet weak var saveExpenseButton: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    expenseCategoryButton.setTitle("Select Expense Category", for: .normal)
    
    tableToSelectTravelers.allowsMultipleSelection = true
    tableToSelectTravelers.delegate = self
    tableToSelectTravelers.dataSource = self
    
    saveExpenseButton.isEnabled = !travelerModel.selectedItems.isEmpty
    
    
    configureTextFields()
    
   
    }
  
  func configureTextFields() {
    amountTextField.text = amountTextFieldPlaceholder
    amountTextField.delegate = self
    amountTextField.textColor = .lightGray
    
    expenseDescriptionField.text = expenseDescriptionPlaceHolder
    expenseDescriptionField.delegate = self
    expenseDescriptionField.textColor = .lightGray
    
  }

  
  @IBAction func expenseCategoryButtonPressed(_ sender: UIButton) {
    arrayOfExpenseCategoryButton.forEach { (button) in
      UIView.animate(withDuration: 0.3, animations: {
        button.isHidden = !button.isHidden
        self.view.layoutIfNeeded()
      })
    }
    
  }
  
  
  
  @IBAction func selectionOfExpenseCategory(_ sender: UIButton) {
    let index = sender.tag
    expenseCategory = arrayOfExpenseCategoryButton[index].titleLabel?.text ?? "Tapped didn't work"
    dump (expenseCategory)
    }
  
  
  @IBAction func selectTravelersButtonPressed(_ sender: UIButton) {
    print(travelerModel.selectedItems.map{$0.title})
    
  }
  
  
  
  func configureExpenseCategoryButton() {
    var index = 0
    for expenseCategory in ExpenseType.allCases {
      arrayOfExpenseCategoryButton[index].setTitle(expenseCategory.rawValue, for: .normal)
      index += 1
    }
  }

}

extension EnterExpenseController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    travelerModel.travelerInfo[indexPath.row].isSelected = true
    
     saveExpenseButton.isEnabled = !travelerModel.selectedItems.isEmpty
    
    
  }
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    travelerModel.travelerInfo[indexPath.row].isSelected = false

     saveExpenseButton.isEnabled = !travelerModel.selectedItems.isEmpty
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 75
  }
  
}

extension EnterExpenseController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return travelerModel.travelerInfo.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableToSelectTravelers.dequeueReusableCell(withIdentifier: "TravelerSharingExpenseCell", for: indexPath) as?  TravelerSharingExpenseCell else { return UITableViewCell()}
    cell.item = travelerModel.travelerInfo[indexPath.row]
    cell.travelerNameLabel.text = travelerModel.travelerInfo[indexPath.row].title
    
    if travelerModel.travelerInfo[indexPath.row].isSelected {
      tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    } else {
      tableView.deselectRow(at: indexPath, animated: false)
    }
    
    return cell
  }
}

extension EnterExpenseController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.text == expenseDescriptionPlaceHolder {
      textField.textColor = .black
      textField.text = ""
    }
    
    if textField.text == amountTextFieldPlaceholder {
     textField.textColor = .black
      textField.text = ""
    }
    
  
    
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    if textField.text == "" {
      textField.textColor = .lightGray
      textField.text = expenseDescriptionPlaceHolder
      textField.text = amountTextFieldPlaceholder
    }
    
    
    
  }
}
