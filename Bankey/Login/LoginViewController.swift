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
    
    // MARK: - Animations
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.style()
        self.layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        submitButton.configuration?.showsActivityIndicator = false
        submitButton.isEnabled = true
        loginView.usernameTextfield.text = ""
        loginView.passwordTextfield.text = ""
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
            bankeyText.topAnchor.constraint(equalToSystemSpacingBelow: bankeyTitle.bottomAnchor, multiplier: 3),
            bankeyText.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            bankeyTitle.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        titleLeadingAnchor = bankeyTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
        subtitleLeadingAnchor = bankeyText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subtitleLeadingAnchor?.isActive = true
        
        loginView.alpha = 0
        submitButton.alpha = 0
        
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
        self.submitButton.configuration?.showsActivityIndicator = true
        self.submitButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let username = self.username, let password = self.password else {
                assertionFailure("Username / password should never be nil")
                return
            }
            
            if username.isEmpty || password.isEmpty {
                self.configureView(withMessage: "Username / Password cannot be blank")
                return
            }
            
            if self.username != "1" && self.password != "1" {
                self.configureView(withMessage: "Wrong username or password")
                return
            }
            
            
            self.delegate?.didLogin()
        }
    }
    
    private func configureView(withMessage message: String) {
        submitButton.configuration?.showsActivityIndicator = false
        submitButton.isEnabled = true
        errorLabel.isHidden = false
        errorLabel.text = message
        shakeButton()
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        submitButton.layer.add(animation, forKey: "shake")
    }
}


// MARK: - Animations
extension LoginViewController {
    private func animate() {
        let titleAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        let subtitleAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        let formAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
            self.loginView.alpha = 1
            self.submitButton.alpha = 1
            self.view.layoutIfNeeded()
        }
        
        formAnimator.startAnimation()
        titleAnimator.startAnimation()
        subtitleAnimator.startAnimation()
    }
}
