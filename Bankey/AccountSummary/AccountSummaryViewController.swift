//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Vitor Trimer on 03/06/22.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    struct Profile {
        let firstName: String
        let lastName: String
    }
    
    var profile: Profile?
    var accounts: [AccountSummaryCell.ViewModel] = []
    
    var header = AccountSummaryHeaderView(frame: .zero)
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAccounts()
        setup()
        layout()
    }
}

extension AccountSummaryViewController {
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        tableView.tableHeaderView = header
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func fetchAccounts() {
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "Basic Savings", balance: 928328.23)
        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "No-Fee All-In chequing", balance: 132821.34)
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Ben Visa Vale", balance: 1000.00)
        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "AAdvantage Platinum", balance: 12658.32)
        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Saver", balance: 500.00)
        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Growth Fund", balance: 4328.90)
        
        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        cell.configure(with: accounts[indexPath.row])
        
        return cell
    }
}

extension AccountSummaryViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
