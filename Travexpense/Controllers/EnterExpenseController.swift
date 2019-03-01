//
//  EnterExpenseController.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/28/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class EnterExpenseController: UIViewController {

  
  @IBOutlet var arrayOfExpenseCategoryButton: [UIButton]!
  
  
  @IBOutlet var arrayOfExpenseTypeButtons: [UIButton]!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

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
  
}
