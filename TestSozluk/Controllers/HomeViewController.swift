//
//  HomeViewController.swift
//  TestSozluk
//
//  Created by MESUT GUNES on 9.01.2021.
//  Copyright © 2021 MesutGunes. All rights reserved.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var dictionaryImg: UIImageView!
    @IBOutlet weak var readmeTxt: UITextView!
    // MARK: Properties
    private let networkManager = NetworkManager()
    
    private var home: Home? {
        didSet {
            readmeTxt.text = home?.readme
        }
    }

    override func viewDidLoad() {
        title = "Anasayfa"
        networkManager.getReadme { (home, errorMessage) in
            DispatchQueue.main.async { [self] in
                self.home = home!
            }
        }

    }
}
