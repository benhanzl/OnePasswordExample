//
//  SignInViewController.swift
//  OnePasswordExample
//
//  Created by Ben Hanzl on 7/23/15.
//  Copyright © 2015 Ben Hanzl. All rights reserved.
//

import OnePasswordExtension
import UIKit

class SignInViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!

  @IBOutlet weak var onePasswordButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    let onePasswordAvailable = OnePasswordExtension.sharedExtension().isAppExtensionAvailable()
    onePasswordButton.hidden = !onePasswordAvailable
  }

  @IBAction func populateFieldsFromOnePassword(sender: UIButton) {
    OnePasswordExtension.sharedExtension().findLoginForURLString("https://izea.com", forViewController: self,
        sender: sender) { (credentials, error) -> Void in
      guard error == nil else {
        print("Error: \(error)")
        return
      }

      guard let credentials = credentials where credentials.count > 0 else {
        print("No credentials selected")
        return
      }

      self.emailTextField.text = credentials[AppExtensionUsernameKey] as? String
      self.passwordTextField.text = credentials[AppExtensionPasswordKey] as? String
    }
  }
}
