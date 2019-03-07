//
//  ImageAPIClient.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/6/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation


final class ImagesClientAPI {
  
  static func searchImage(selectedCountryName: String, completionHandler: @escaping (AppError?, [ImageDetailedInfo]?) -> Void){
    
    let city = selectedCountryName.replacingOccurrences(of: " ", with: "+")
    
    let urlString = "https://pixabay.com/api/?key=\(SecretKeys.imageAPIKey)&q=\(city)&image_type=photo"
    
    NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
      
      if let appError = appError {
        completionHandler(appError, nil)
      }
      guard let response = httpResponse,
        (200...299).contains(response.statusCode) else {
          let statusCode = httpResponse?.statusCode ?? -999
          completionHandler(AppError.badStatusCode(String(statusCode)), nil)
          return
      }
      if let data = data {
        do {
          let imageData = try JSONDecoder().decode(ImageModel.self, from: data)
          completionHandler(nil, imageData.hits)
        } catch {
          completionHandler(AppError.jsonDecodingError(error), nil)
        }
      }
    }
  }
  
}
