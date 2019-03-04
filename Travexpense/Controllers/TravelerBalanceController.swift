//
//  AddExpenseController.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/28/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit


class TravelerBalanceController: UIViewController {

  var travelerSentFromOverview: TravelerInfo!

  
  @IBOutlet weak var currentUserImage: UIImageView!
  @IBOutlet weak var currentUserName: UILabel!
  
  
  
  @IBOutlet weak var userWhoseBalaceIsComparedImage: UIImageView!
  
  @IBOutlet weak var userWhoseBalanceLabel: UILabel!
  
  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      tableView.dataSource = self
      tableView.delegate = self
      
    self.currentUserName.text = travelerSentFromOverview.title
      
    }
  
}

extension TravelerBalanceController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell") else {return UITableViewCell()}
    
   cell.textLabel?.text = "hello"
    
    return cell
  }


}
