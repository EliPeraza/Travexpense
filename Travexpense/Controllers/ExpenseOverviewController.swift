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
  @IBOutlet weak var expenseCollectionView: UICollectionView!
  @IBOutlet weak var travelersCollectionView: UICollectionView!
  
  let travelerModel = TravelerModel()
  let expenseCategory = ["Transportation", "Lodging", "Entertainment", "Food"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    expenseCollectionView.delegate = self
    expenseCollectionView.dataSource = self
    
    travelersCollectionView.delegate = self
    travelersCollectionView.dataSource = self
    
  }
 
  
  
  @IBAction func addExpenseButtonPressed(_ sender: UIButton) {
    
  }
  
}

extension ExpenseOverviewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    switch collectionView {
    case travelersCollectionView:
      return travelerModel.travelerInfo.count
    case expenseCollectionView:
      print("this is the count for expense category \(expenseCategory.count)")

      return expenseCategory.count
    default:
      return 4
    }
   
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch  collectionView {
    case travelersCollectionView:
      guard let cell = travelersCollectionView.dequeueReusableCell(withReuseIdentifier: "TravelerCell", for: indexPath) as? TravelersCell else {return UICollectionViewCell()}
      cell.travelerImage.image = UIImage(named: "traveler")
      cell.travelUsername.text = travelerModel.travelerInfo[indexPath.row].title
      return cell
    case expenseCollectionView:
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
    default:
      let cell = UICollectionViewCell()
      return cell
    }
  
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch  collectionView {
    case travelersCollectionView:
      return CGSize.init(width: (travelersCollectionView.bounds.width) / 2, height: travelersCollectionView.bounds.height)
    case expenseCollectionView:
      return CGSize.init(width: 130, height: 130)

    default:
      return CGSize.init(width: 200, height: 300)
    }
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //Segue user
  }
  
}

