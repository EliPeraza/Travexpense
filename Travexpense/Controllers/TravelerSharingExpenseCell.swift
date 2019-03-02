//
//  TravelerSharingExpenseCell.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/1/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class TravelerSharingExpenseCell: UITableViewCell {

  
  @IBOutlet weak var travelerPhoto: UIImageView!
  
  @IBOutlet weak var travelerNameLabel: UILabel!
  
  var item: TravelerInfo? {
    didSet{
     travelerNameLabel.text = item?.title
    }
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
      selectionStyle = .none
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      accessoryType = selected ? .checkmark : .none
      
    }

}
