//
//  ViewController.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class ExpenseOverviewController: UIViewController {
  
  @IBOutlet weak var transportationLabel: UILabel!
  @IBOutlet weak var transportationButton: UIButton!
  
  @IBOutlet weak var lodgingLabel: UILabel!
  
  @IBOutlet weak var lodgingButton: UIButton!
  
  @IBOutlet weak var entertainmentLabel: UILabel!
  
  @IBOutlet weak var entertainmentButton: UIButton!
  
  @IBOutlet weak var totalButton: UIButton!
  
  @IBOutlet weak var totalLabel: UILabel!
  
  @IBOutlet weak var travelersCollectionView: UICollectionView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()


  }

  
  @IBAction func addExpenseButtonPressed(_ sender: UIButton) {
    
  }
  
}

