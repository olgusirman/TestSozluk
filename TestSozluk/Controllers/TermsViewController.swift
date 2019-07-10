//
//  TermsViewController.swift
//  TestSozluk
//
//  Created by Olgu Sırman on 10.07.2019.
//  Copyright © 2019 MesutGunes. All rights reserved.
//

import UIKit

final class TermsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: Properties
    private let networkManager = NetworkManager()
    
    private var terms: [Term]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sözlük"
        
        networkManager.getTerms { [weak self] (terms, errorMessage) in
            DispatchQueue.main.async {
                self?.terms = terms
            }
        }
        
    }

}

extension TermsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TermsCell.self)) as! TermsCell
        
        if let term = terms?[indexPath.row] {
            cell.termLabel.text = term.term
            cell.meaningLabel.text = term.meaning
        }
        
        return cell
    }
    
}
