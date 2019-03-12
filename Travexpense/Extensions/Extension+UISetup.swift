//
//  Extension+UISetup.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/7/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

extension UIViewController {
  
  func buttonUISetup(_ button: UIButton) {
    button.layer.cornerRadius = 2.5
    button.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    button.layer.borderWidth = 0.5
  }
  
  
//  public func queryForCurrentUser(userID: String) {
//    // Query - for the user who created this race review
//    let query = DatabaseManager.firebaseBD.collection(DatabaseKeys
//      .UsersCollectionKey).whereField("userID", isEqualTo: userID)
//
//    query.getDocuments { (snapshot, error) in
//      if let error = error {
//
//        self.showAlert(title: "Network Error", message: error.localizedDescription, actionTitle: "Try Again")
//
//      } else if let snapshot = snapshot {
//        guard let firstDocument = snapshot.documents.first else {
//          print("no document found")
//          return
//        }
//
//        let currentUser = TEUser(dict: firstDocument.data())
//        DispatchQueue.main.async {
//          self.usernameLabel.text = "reviewed by @\(reviewer.username ?? "no ussername")"
//        }
//
//        // setting up image url
//        guard let imageURL = currentUser.imageURL,
//          !imageURL.isEmpty else {
//            print("no imageURL")
//            return
//        }
//        if let image = ImageCache.shared.fetchImageFromCache(urlString: imageURL) {
//          self.detailView.reviewersProfileImageView.image = image
//        } else {
//          ImageCache.shared.fetchImageFromNetwork(urlString: imageURL) { (appError, image) in
//            if let appError = appError {
//              self.showAlert(title: "Fetching Image Error", message: appError.errorMessage(), actionTitle: "Ok")
//            } else if let image = image {
//              self.detailView.reviewersProfileImageView.image = image
//            }
//          }
//        }
//
//      }
//    }
//  }
  
}
