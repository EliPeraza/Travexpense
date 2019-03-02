//
//  EnterExpenseController.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/28/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class EnterExpenseController: UIViewController {

  var travelers = SelectedTravelers()
  

  @IBOutlet var arrayOfExpenseCategoryButton: [UIButton]!
  
  
  @IBOutlet var arrayOfExpenseTypeButtons: [UIButton]!
  
  
  @IBOutlet weak var amountTextField: UITextField!
  
  @IBOutlet weak var expenseDescriptionField: UITextField!
  
  @IBOutlet weak var tableToSelectTravelers: UITableView!
  
  
  @IBOutlet weak var buttonToAddSelectedTravelers: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    buttonToAddSelectedTravelers.isEnabled = !travelers.selectedTravelers.isEmpty

    tableToSelectTravelers.delegate = self
    tableToSelectTravelers.dataSource = self
    
    }
    
  @IBAction func expenseCategoryButtonPressed(_ sender: UIButton) {
    arrayOfExpenseCategoryButton.forEach { (button) in
      UIView.animate(withDuration: 0.3, animations: {
        button.isHidden = !button.isHidden
        self.view.layoutIfNeeded()
      })
    }
  }
  
  
  @IBAction func expenseTypeButtonPressed(_ sender: UIButton) {
    arrayOfExpenseTypeButtons.forEach { (button) in
      UIView.animate(withDuration: 0.3, animations: {
        button.isHidden = !button.isHidden
        self.view.layoutIfNeeded()
      })
    }
  }
  
  
  @IBAction func selectTravelersButtonPressed(_ sender: UIButton) {
    print(travelers.selectedTravelers.map{$0.travelerName})
  }
  
}

extension EnterExpenseController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    travelers.travelers[indexPath.row].isTravelerSelected = true
    
    buttonToAddSelectedTravelers.isEnabled = !travelers.selectedTravelers.isEmpty
    
    
  }
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    travelers.travelers[indexPath.row].isTravelerSelected = false
    
    buttonToAddSelectedTravelers.isEnabled = !travelers.selectedTravelers.isEmpty
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
}

extension EnterExpenseController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return travelers.travelers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableToSelectTravelers.dequeueReusableCell(withIdentifier: "TravelerSharingExpenseCell", for: indexPath) as?  TravelerSharingExpenseCell else { return UITableViewCell()}
    
    cell.travelerNameLabel.text = travelers.travelers[indexPath.row].travelerName
    
//    if travelers.selectedTravelers[indexPath.row].isTravelerSelected{
//      tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
//    } else {
//      tableView.deselectRow(at: indexPath, animated: false)
//    }
    
    return cell 
  }
}
