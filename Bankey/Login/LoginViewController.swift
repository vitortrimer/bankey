//
//  ViewController.swift
//  Bankey
//
//  Created by Vitor Trimer on 16/05/22.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let stackView = UIStackView()
    let loginView = LoginView()
    let submitButton = UIButton(type: .system)
    let errorLabel = UILabel()
    let bankeyTitle = UILabel()
    let bankeyText = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextfield.text
    }
    var password: String? {
        return loginView.passwordTextfield.text
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.style()
        self.layout()
        
    }
}


// MARK: - Layout
extension LoginViewController {
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        self.submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.submitButton.configuration = .filled()
        self.submitButton.configuration?.imagePadding = 8
        self.submitButton.setTitle("Submit", for: [])
        self.submitButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.text = ""
        errorLabel.isHidden = true
        
        bankeyTitle.translatesAutoresizingMaskIntoConstraints = false
        bankeyTitle.textAlignment = .center
        bankeyTitle.numberOfLines = 0
        bankeyTitle.font = UIFont.boldSystemFont(ofSize: 32)
        bankeyTitle.text = "Bankey"
        
        bankeyText.translatesAutoresizingMaskIntoConstraints = false
        bankeyText.textAlignment = .center
        bankeyText.numberOfLines = 0
        bankeyText.font = UIFont.systemFont(ofSize: 20)
        bankeyText.text = "Your premium source for all things banking!"
        
    }
    
    private func layout() {
        view.addSubview(bankeyTitle)
        view.addSubview(bankeyText)
        view.addSubview(loginView)
        view.addSubview(submitButton)
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2),
            
            submitButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            submitButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: submitButton.bottomAnchor, multiplier: 1),
            errorLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: bankeyText.bottomAnchor, multiplier: 2),
            bankeyText.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: bankeyText.trailingAnchor, multiplier: 2),
            
            bankeyText.topAnchor.constraint(equalToSystemSpacingBelow: bankeyTitle.bottomAnchor, multiplier: 3),
            bankeyTitle.leadingAnchor.constraint(equalTo: bankeyText.leadingAnchor),
            bankeyTitle.trailingAnchor.constraint(equalTo: bankeyTitle.trailingAnchor),
            bankeyTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}


// MARK: - Actions
extension LoginViewController {
    @objc func signInTapped() {
        errorLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / Password cannot be blank")
            return
        }
        
        if username != "1" && password != "1" {
            configureView(withMessage: "Wrong username or password")
            return
        }
        
        // redirect
        delegate?.didLogin()
        submitButton.configuration?.showsActivityIndicator = true
        submitButton.isEnabled = false
    }
    
    private func configureView(withMessage message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
}
