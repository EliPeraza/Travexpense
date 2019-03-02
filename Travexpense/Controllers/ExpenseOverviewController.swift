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
  
  let travelerModel = TravelerModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    travelersCollectionView.delegate = self
    
    travelersCollectionView.dataSource = self
    
  }
  
  
  @IBAction func addExpenseButtonPressed(_ sender: UIButton) {
    
  }
  
}

extension ExpenseOverviewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return travelersInTrip.travelers.count
    
    return travelerModel.travelerInfo.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = travelersCollectionView.dequeueReusableCell(withReuseIdentifier: "TravelerCell", for: indexPath) as? TravelersCell else {return UICollectionViewCell()}
    cell.travelerImage.image = UIImage(named: "traveler")
    cell.travelUsername.text = travelerModel.travelerInfo[indexPath.row].title
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: (travelersCollectionView.bounds.width) / 2, height: travelersCollectionView.bounds.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //Segue user
  }
  
}

