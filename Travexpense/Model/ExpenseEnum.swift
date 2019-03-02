//
//  ExpenseEnum.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 2/27/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

enum Travelers: String, CaseIterable {
  case eli = "Eli"
  case oli = "Oli"
  case jeff = "Jeff"
  case aaron = "Aaron"
  case Protesh = "Pritesh"
}

enum ExpenseType: String, CaseIterable {
  case transportation = "Transportation"
  case lodging = "Lodging"
  case entertainment = "Entertainment"
  case food = "Food"
  case other = "Other"
}

enum Transportation: String,CaseIterable {
  case flight = "Flight"
  case train = "Train"
  case carRental = "Car or Bike Rental"
  case other = "Other"
}

enum Lodging: String, CaseIterable {
  case hotel = "Hotel"
  case hostel = "Hostel"
  case airBAndB = "Airbnb"
  case other = "Other"
}

enum Entertainment: String, CaseIterable {
  case museum = "Mueseum"
  case tour = "Tour"
  case show = "Show"
  case other = "Other"
}

enum FoodAndBeverage: String, CaseIterable {
  case food = "Food"
  case drinks = "Drinks"
  case snacks = "Snacks"
  case other = "Other"
}


