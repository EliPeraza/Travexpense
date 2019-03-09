//
//  ViewController.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit
import Kingfisher


class ExpenseOverviewController: UIViewController {
  
  
  
  @IBOutlet weak var placeName: UILabel!
  
  @IBOutlet weak var placeImage: UIImageView!
  
  //  @IBOutlet weak var instuctionLabelOne: UILabel!
  //
  //  @IBOutlet weak var instructionLabelTwo: UILabel!
  @IBOutlet weak var expenseCollectionView: UICollectionView!
  
  @IBOutlet weak var instructionLabelThree: UILabel!
  
  @IBOutlet weak var travelerBalanceTableView: UITableView!
  
  let travelerModel = TravelerModel()
  let expenseCategory = ["Transportation", "Lodging", "Entertainment", "Food"]
  
  var expensesDataFromDataBase = [ExpenseModel]() {
    didSet {
      DispatchQueue.main.async {
        
      }
    }
  }
  
  var imageData = [ImageDetailedInfo] () {
    didSet {
      DispatchQueue.main.async {
        let image = Int.random(in: 0..<self.imageData.count)
        ImageHelper.shared.fetchImage(urlString: self.imageData[image].largeImageURL) { (appError, image) in
          if let appError = appError {
            print(appError)
          }
          if let image = image {
            DispatchQueue.main.async {
              self.placeImage.image = image
            }
          }
        }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    expenseCollectionView.delegate = self
    expenseCollectionView.dataSource = self
    
    travelerBalanceTableView.delegate = self
    travelerBalanceTableView.dataSource = self
    
    //    instuctionLabelOne.text = "Checkout the money stuff below!"
    //    instructionLabelTwo.text = """
    //    Click on a name to see a detailed balance with a friend.
    //    Green: people owe you money. Red: You owe them money
    //    """
    instructionLabelThree.text = "Click below for a trip expense overview:"
    placeName.text = "Peru"
    
    
    getDataFromFireBase()
    
//    let urlString = "https://pixabay.com/api/?key=\(SecretKeys.imageAPIKey)&q=peru&image_type=photo"
//
//    placeImage.kf.setImage(with: URL(string: urlString), placeholder: UIImage(named: "imageTest"))
    
    getRandomImage()
    
  }
  
  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //    guard let indexPath = travelerBalanceTableView.indexPathForSelectedRow,
  //      let traverlerBalanceVC = segue.destination as? TravelerBalanceController else {fatalError("Error in segue")}
  //    let currentUserBeinSegue = travelerModel.travelerInfo[indexPath.row]
  //
  //    traverlerBalanceVC.travelerSentFromOverview = currentUserBeinSegue
  //  }
  
  
  @IBAction func AddExpenseButtonPressed(_ sender: UIBarButtonItem) {
    let enterExpenseController = EnterExpenseController()
    navigationController?.pushViewController(enterExpenseController, animated: true)
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
  
  private func getRandomImage() {
    ImagesClientAPI.searchImage(selectedCountryName: "peru") { (appError, images) in
      if let appError = appError {
        print(appError)
      }
      if let data = images {
        self.imageData = data
        dump(self.imageData)
      }
    }
  }
  
}


extension ExpenseOverviewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return expenseCategory.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = expenseCollectionView.dequeueReusableCell(withReuseIdentifier: "TripExpenseOverviewCell", for: indexPath) as? TripExpenseOverviewCell else {return UICollectionViewCell()}

    switch ExpenseType.allCases[indexPath.row].rawValue.lowercased(){
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
    
    //    return CGSize.init(width: 80, height: 80)
    return CGSize(width: 80, height: 80)
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let traverlerBalanceVC = TravelerBalanceController()
    let currentUserBeinSegue = travelerModel.travelerInfo[indexPath.row].title
    print("this is the current thing to segue: \(currentUserBeinSegue)")
    
    traverlerBalanceVC.travelerSentFromOverview = currentUserBeinSegue
    navigationController?.pushViewController(traverlerBalanceVC, animated: true
    )
  }
  
  
  
}

