//
//  LoginView.swift
//  Bankey
//
//  Created by Vitor Trimer on 24/05/22.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    //MARK: - Elements
    let stackView = UIStackView()
    let usernameTextfield = UITextField()
    let divider = UIView()
    let passwordTextfield = UITextField()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.style()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

// MARK: - Layout

extension LoginView {
    
    func style() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.spacing = 8
        
        self.usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        self.usernameTextfield.placeholder = "Username"
        self.usernameTextfield.delegate = self
        
        self.divider.backgroundColor = .systemGray4
        
        self.passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextfield.placeholder = "Password"
        self.passwordTextfield.isSecureTextEntry = true
        self.passwordTextfield.enablePasswordToggle()
        self.passwordTextfield.delegate = self
    }
    
    func layout() {
        self.stackView.addArrangedSubview(usernameTextfield)
        self.stackView.addArrangedSubview(divider)
        self.stackView.addArrangedSubview(passwordTextfield)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            self.stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: self.stackView.trailingAnchor, multiplier: 1),
            self.bottomAnchor.constraint(equalToSystemSpacingBelow: self.stackView.bottomAnchor, multiplier: 1),
            self.divider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.usernameTextfield.endEditing(true)
        self.passwordTextfield.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
