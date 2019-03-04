//
//  AddExpenseController.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/28/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

struct CellExpansion {
  var opened: Bool
  var title: String
  var sectionData = [String]()
}


class TravelerBalanceController: UIViewController {

  var travelerSentFromOverview: TravelerInfo!

  var tableViewData = [CellExpansion]()
  
  @IBOutlet weak var currentUserImage: UIImageView!
  @IBOutlet weak var currentUserName: UILabel!
  
  
  
  @IBOutlet weak var userWhoseBalaceIsComparedImage: UIImageView!
  
  @IBOutlet weak var userWhoseBalanceLabel: UILabel!
  
  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      tableView.dataSource = self
      tableView.delegate = self
      
      tableViewData = [CellExpansion(opened: false, title: "title 1", sectionData: ["Cell 1", "Cell 2", "Cell 3"]),
                       CellExpansion(opened: false, title: "title 2", sectionData: ["Cell 1", "Cell 2", "Cell 3"]),
                       CellExpansion(opened: false, title: "title 3", sectionData: ["Cell 1", "Cell 2", "Cell 3"]),
                       CellExpansion(opened: false, title: "title 4", sectionData: ["Cell 1", "Cell 2", "Cell 3"])]
      
    setupUI()
      
    }
  
  func setupUI() {
    self.currentUserName.text = "Eli"
    self.userWhoseBalanceLabel.text = travelerSentFromOverview.title
  }
  
}

extension TravelerBalanceController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return tableViewData.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableViewData[section].opened {
      return tableViewData[section].sectionData.count + 1
    } else {
     return 1
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell") else {return UITableViewCell()}
    
    if indexPath.row == 0 {
      cell.textLabel?.text = tableViewData[indexPath.section].title
      return cell
    } else {
      cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
      return cell
    }
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row ==  0{
      if tableViewData[indexPath.section].opened == true {
        tableViewData[indexPath.section].opened = false
        let sections = IndexSet.init(integer: indexPath.section)
        tableView.reloadSections(sections, with: .none)
      } else {
        tableViewData[indexPath.section].opened = true
        let sections = IndexSet.init(integer: indexPath.section)
        tableView.reloadSections(sections, with: .none)
      }
    }
  }


}
