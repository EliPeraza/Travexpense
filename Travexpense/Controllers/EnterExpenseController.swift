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
  var expenseDescription =  String()
  var expenseAmount = Double()
  var travelersToShareExpense = [String]()
  var dictionaryOfTravelers = [String:String]()
  
  
  private var amountTextFieldPlaceholder = "Enter total amount for the expense"
  private var expenseDescriptionPlaceHolder = "Enter expense description. Example: 'Train to Paris'"
  
  var travelerModel = TravelerModel()
  
  @IBOutlet var arrayOfExpenseCategoryButton: [UIButton]!
  
  @IBOutlet weak var expenseCategoryButton: UIButton! 
  
  @IBOutlet weak var amountTextField: UITextField!
  
  @IBOutlet weak var expenseDescriptionField: UITextField!
  
  @IBOutlet weak var tableToSelectTravelers: UITableView!
  
  
  @IBOutlet weak var saveSelectedTravelersButton: UIButton!
  
  @IBOutlet weak var saveExpenseEntry: UIButton!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    expenseCategoryButton.setTitle("Select Expense Category", for: .normal)
    
    tableToSelectTravelers.allowsMultipleSelection = true
    tableToSelectTravelers.delegate = self
    tableToSelectTravelers.dataSource = self
    
    saveSelectedTravelersButton.isEnabled = !travelerModel.selectedItems.isEmpty
    
    
    configureTextFields()
    configureExpenseCategoryButton()
    
    amountTextField.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
    
  }
  
  @objc func myTextFieldDidChange(_ textField: UITextField) {
    expenseAmount = Double(textField.text ?? "nothing") ?? 0.0
    
    if let amountString = textField.text{
      
      textField.text = amountString.currencyInputFormatting()
      print("This is the xpense amount to be saved \(expenseAmount)")
    }
  }
  
  
  @IBAction func expenseCategoryButtonPressed(_ sender: UIButton) {
    expenseCategoryButtonAnimation()
  }
  
  
  @IBAction func saveSelectedButton(_ sender: UIButton) {
    let buttonTitle = sender.titleLabel?.text ?? "Button doesn't have a title"
    
    switch buttonTitle.lowercased(){
    case "transportation":
      updateButtonConfiguration(buttonTitle: buttonTitle)
    case "lodging":
      updateButtonConfiguration(buttonTitle: buttonTitle)
    case "entertainment":
      updateButtonConfiguration(buttonTitle: buttonTitle)
    case "food":
      updateButtonConfiguration(buttonTitle: buttonTitle)
    default:
      print("THE SWITCH IS NOT WORKING")
    }
  }
  
  @IBAction func selectTravelersButtonPressed(_ sender: UIButton) {
    
    travelersToShareExpense = travelerModel.selectedItems.map{$0.title}
    
    let displayNames = travelersToShareExpense.joined(separator: ", ")
    
    showAlert(title: "Split this expense among:", message: displayNames) { (alert) in
      let ok = UIAlertAction(title: "Ok", style: .default) { (done) in
        
        
        for person in self.travelersToShareExpense {
          self.dictionaryOfTravelers[person] = person
          print(self.dictionaryOfTravelers)
        }

        }

      let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alert.addAction(ok)
      alert.addAction(cancel)
      self.present(alert, animated: true, completion: nil)
    }
    
    print("travelers sharing expense: \(travelersToShareExpense)")
    
    
  }
  
  
  @IBAction func saveExpenseCompleteEntryButtonPressed(_ sender: UIButton) {
    
    
    guard let expenseDescription = expenseDescriptionField.text,
      !expenseDescription.isEmpty else {
        showAlert(title: "Missing Description", message: "Please enter more info")
        return
    }
    
    guard !travelersToShareExpense.isEmpty else {
     showAlert(title: "Select Travelers", message: "Select and add travelers you are sharing the expense with")
      return
    }
    
    
    let expense = ExpenseModel.init(expenseCategory: expenseCategory, expenseSubcategory: "nothing-refactor", expenseDescription: expenseDescription, expenseAmount: expenseAmount, travelersSharingExpense: ["Ess" : "Oli"])
    
    print("This is an expense\(expense)")
    
  }
  
  
  
  
  private func configureTextFields() {
    amountTextField.text = amountTextFieldPlaceholder
    amountTextField.delegate = self
    amountTextField.textColor = .lightGray
    
    expenseDescriptionField.text = expenseDescriptionPlaceHolder
    expenseDescriptionField.delegate = self
    expenseDescriptionField.textColor = .lightGray
  }
  
  private func configureExpenseCategoryButton() {
    var index = 0
    for expenseCategory in ExpenseType.allCases {
      arrayOfExpenseCategoryButton[index].setTitle(expenseCategory.rawValue, for: .normal)
      index += 1
    }
  }
  
  private func updateButtonConfiguration(buttonTitle: String) {
    expenseCategory = buttonTitle
    expenseCategoryButton.setTitle(buttonTitle, for: .normal)
    expenseCategoryButtonAnimation()
    arrayOfExpenseCategoryButton.forEach { (button) in
      button.isEnabled = false
    }
  }
  
  
  private func expenseCategoryButtonAnimation(){
    arrayOfExpenseCategoryButton.forEach { (button) in
      UIView.animate(withDuration: 0.3, animations: {
        button.isHidden = !button.isHidden
        self.view.layoutIfNeeded()
      })
    }
  }
}

extension EnterExpenseController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    travelerModel.travelerInfo[indexPath.row].isSelected = true
    
    saveSelectedTravelersButton.isEnabled = !travelerModel.selectedItems.isEmpty
    
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    travelerModel.travelerInfo[indexPath.row].isSelected = false
    
    saveSelectedTravelersButton.isEnabled = !travelerModel.selectedItems.isEmpty
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
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let characterLimit = 150
    let startingLength = expenseDescriptionField.text?.count ?? 0
    let lengthToAdd = string.count
    let lengthToReplace = range.length
    let newLength = startingLength + lengthToAdd - lengthToReplace
    return newLength <= characterLimit
    
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.text == expenseDescriptionPlaceHolder {
      textField.textColor = .black
      textField.text = ""
    }
    
    if textField.text == amountTextFieldPlaceholder {
      becomeFirstResponder()
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
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == amountTextField {
      expenseDescriptionField.becomeFirstResponder()
    }
    
    if textField == expenseDescriptionField {
      self.view.endEditing(true)
    }
    return true
  }
}

extension String {
  
  /*Source: https://github.com/vivatum/Currency_Format_from_left_to_right/blob/master/TextFieldCurrencyFormat/ViewController.swift*/
  
  func currencyInputFormatting() -> String {
    
    var number: NSNumber!
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "$"
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    
    var amountWithPrefix = self
    
    // remove from String: "$", ".", ","
    let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
    amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
    
    let double = (amountWithPrefix as NSString).doubleValue
    number = NSNumber(value: (double / 100))
    
    // if first number is 0 or all numbers were deleted
    guard number != 0 as NSNumber else {
      return ""
    }
    
    return formatter.string(from: number)!
  }
}


//  @IBAction func amountTextAction(_ sender: UITextField) {
//    let text = sender.text ?? "nothing"
//    cleanDollars(text)
//    expenseAmount = Double(cleanDollars(text)) ?? 0.0
//  }
//
//  func cleanDollars(_ value: String?) -> String {
//    guard value != nil else { return "$0.00" }
//    let doubleValue = Double(value!) ?? 0.0
//    let formatter = NumberFormatter()
//    formatter.currencyCode = "USD"
//    formatter.currencySymbol = "$"
//    formatter.minimumFractionDigits = (value!.contains(".00")) ? 0 : 2
//    formatter.maximumFractionDigits = 2
//    formatter.numberStyle = .currencyAccounting
//    return formatter.string(from: NSNumber(value: doubleValue)) ?? "$\(doubleValue)"
//  }



//    @IBAction func selectionOfExpenseCategory(_ sender: UIButton) {
//      let index = sender.tag
//      expenseCategory = arrayOfExpenseCategoryButton[index].titleLabel?.text ?? "Tapped didn't work"
//    }
//
//



/*  var expenseCategory = String()
 var expenseDescription =  String()
 var expenseAmount = String()
 var travelersToShareExpense = [String]()*/


//  @objc func expenseDescriptionEditingEnded(_ textField: UITextField){
//    if let expenseDescriptionUnwrapped = expenseDescriptionField.text {
//     expenseDescription = expenseDescriptionUnwrapped
//      print("this is the expense description to save \(expenseDescription)")
//      resignFirstResponder()
//    }
//  }
//    expenseDescriptionField.addTarget(self, action: #selector(expenseDescriptionEditingEnded(_:)), for: .editingDidEnd)
