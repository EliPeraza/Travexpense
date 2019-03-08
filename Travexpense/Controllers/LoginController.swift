//
//  LoginController.swift
//  Travexpense
//
//  Created by Elizabeth Peraza  on 3/7/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
  
  
  @IBOutlet var loginView: LoginView!
  
  private var usersession: UserSession!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loginView.delegate = self
    usersession = (UIApplication.shared.delegate as! AppDelegate).usersession
    usersession.userSessionAccountDelegate = self
    usersession.usersessionSignInDelegate = self
    loginView.emailTextField.delegate = self
    loginView.passwordTextFiled.delegate = self
  }
}

extension LoginController: LoginViewDelegate {
  func didSelectLoginButton(_ loginView: LoginView, accountLoginState: AccountLoginState) {
    guard let email = loginView.emailTextField.text,
      let password = loginView.passwordTextFiled.text,
      !email.isEmpty,
      !password.isEmpty else {
        showAlert(title: "Error with password", message: "")
        return
    }
    switch accountLoginState {
    case .newAccount:
      usersession.createNewAccount(email: email, password: password)
    case .existingAccount:
      usersession.signInExistingUser(email: email, password: password)
    }
  }
}

extension LoginController: UserSessionAccountCreationDelegate {
  func didCreateAccount(_ userSession: UserSession, user: User) {
    
    showAlert(title: "Account Creater", message: "FFFFFFF") { (alert) in
      let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
      let navController = storyboard.instantiateViewController(withIdentifier: "MainNavigationController")
      self.present(navController, animated: true, completion: nil)
    }
   
  }
  
  func didRecieveErrorCreatingAccount(_ userSession: UserSession, error: Error) {
    showAlert(title: "Account creation error", message: error.localizedDescription)
    
  }
}

extension LoginController: UserSessionSignInDelegate {
  func didRecieveSignInError(_ usersession: UserSession, error: Error) {
    showAlert(title: "Sign in Error", message: error.localizedDescription)
  }
  
  func didSignInExistingUser(_ usersession: UserSession, user: User) {
    self.presentMainNavigationController()
  }
  
  private func presentMainNavigationController() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let raceReviewTabController = storyboard.instantiateViewController(withIdentifier: "MainNavigationController")
    raceReviewTabController.modalTransitionStyle = .crossDissolve
    raceReviewTabController.modalPresentationStyle = .overFullScreen
    self.present(raceReviewTabController, animated: true)
  }
}

extension LoginController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    loginView.emailTextField.resignFirstResponder()
    loginView.passwordTextFiled.resignFirstResponder()
    return true
    
  }
}
