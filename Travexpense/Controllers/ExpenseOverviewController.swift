//
//  ViewController.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class ExpenseOverviewController: UIViewController {
  
  
  @IBOutlet weak var placeName: UILabel!
  
  @IBOutlet weak var placeImage: UIImageView!
  
  @IBOutlet weak var instuctionLabelOne: UILabel!
  
  @IBOutlet weak var instructionLabelTwo: UILabel!
  @IBOutlet weak var expenseCollectionView: UICollectionView!
  
  @IBOutlet weak var instructionLabelThree: UILabel!
  
  @IBOutlet weak var travelerBalanceTableView: UITableView!
  
  let travelerModel = TravelerModel()
  let expenseCategory = ["Transportation", "Lodging", "Entertainment", "Food"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    expenseCollectionView.delegate = self
    expenseCollectionView.dataSource = self
    
    travelerBalanceTableView.delegate = self
    travelerBalanceTableView.dataSource = self
    
    instuctionLabelOne.text = "Checkout the money stuff below!"
    instructionLabelTwo.text = """
    Click on a name to see a detailed balance with a friend.
    Green: people owe you money. Red: You owe them money
    """
    instructionLabelThree.text = "Click below for a trip expense overview:"
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = travelerBalanceTableView.indexPathForSelectedRow,
      let traverlerBalanceVC = segue.destination as? TravelerBalanceController else {fatalError("Error in segue")}
    let currentUserBeinSegue = travelerModel.travelerInfo[indexPath.row]
    
    traverlerBalanceVC.travelerSentFromOverview = currentUserBeinSegue
  }
  
  
  @IBAction func addExpenseButtonPressed(_ sender: UIButton) {
    
  }
  
}

extension ExpenseOverviewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return expenseCategory.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = expenseCollectionView.dequeueReusableCell(withReuseIdentifier: "TripExpenseOverviewCell", for: indexPath) as? TripExpenseOverviewCell else {return UICollectionViewCell()}
    
    cell.categoryName.text = expenseCategory[indexPath.row]
    
    switch expenseCategory[indexPath.row].lowercased(){
    case "transportation":
      cell.categoryImage.image = UIImage(named: "train")
    case "lodging":
      cell.categoryImage.image = UIImage(named: "lodging")
      
    case "entertainment":
      cell.categoryImage.image = UIImage(named: "tickets")
      
    case "food":
      cell.categoryImage.image = UIImage(named: "food")
      
    default:
      cell.categoryImage.image = UIImage(named: "traveler")
      
    }
    
    cell.layer.cornerRadius = 5.0
    cell.layer.borderColor = #colorLiteral(red: 0.4309224188, green: 0.5425195694, blue: 0.6682616472, alpha: 1)
    cell.layer.borderWidth = 1.0
    
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize.init(width: 80, height: 80)
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //Segue user
  }
  
}

extension ExpenseOverviewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return travelerModel.travelerInfo.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = travelerBalanceTableView.dequeueReusableCell(withIdentifier: "TravelerBalance", for: indexPath)
    let currentTraveler = travelerModel.travelerInfo[indexPath.row]
    cell.textLabel?.text = currentTraveler.title
    cell.imageView?.image = UIImage(named: "traveler")
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Traveler's balance:"
  }
  

  
}

