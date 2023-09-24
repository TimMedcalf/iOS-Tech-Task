//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit
import Networking

enum LoginSegueIdentifier {
    static let accounts = "accountsSegue"
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                  for: .editingChanged)
        updateLoginState()
    }

    
    @IBAction func loginButtonTapped(_ sender: Any) {
            guard let email = emailTextField.text?.trimmed(),
                  let password = passwordTextField.text?.trimmed() else { return }
            let loginRequest = LoginRequest.init(email: email, password: password)
            Coordinator.dataProvider.login(request: loginRequest) { result in
                if case .failure(let error) = result {
                    let errorPresenter = ErrorAlertPresenter(message: "Could not log in: \(error.localizedDescription)")
                    errorPresenter.present(in: self)
                }
            }
        }
    }
    
// MARK: UITextFieldDelegate methods
extension LoginViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateLoginState()
    }

    func updateLoginState() {
        guard let email = emailTextField.text,
            !email.isEmpty,
            passwordTextField.hasText else {
            enableLoginButton(false)
            return
        }
        enableLoginButton(email.isValidEmailAddress())
    }

    func enableLoginButton(_ enable: Bool) {
        runOnMainThread {
            self.loginButton.isUserInteractionEnabled = enable
            self.loginButton.tintColor = enable ? UIColor(named: "AccentColor")  : UIColor.lightGray
        }
    }


    
}
