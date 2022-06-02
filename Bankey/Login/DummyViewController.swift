//
//  DummyViewController.swift
//  Bankey
//
//  Created by Vitor Trimer on 02/06/22.
//

import Foundation
import UIKit

class DummyViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let logoutBtn = UIButton(type: .system)
    
    weak var delegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        logoutBtn.configuration = .filled()
        logoutBtn.setTitle("Logout", for: [])
        logoutBtn.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
        
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutBtn)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func logoutTapped(sender: UIButton) {
        delegate?.didLogout()
    }
}
