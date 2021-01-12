//
//  HomeViewController.swift
//  TestSozluk
//
//  Created by MESUT GUNES on 9.01.2021.
//  Copyright © 2021 MesutGunes. All rights reserved.
//

import Foundation
import UIKit
import MarkdownView
import WebKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var dictionaryImg: UIImageView!
    @IBOutlet var readmeMd: MarkdownView!

    // MARK: Properties
    private let networkManager = NetworkManager()
    
    private var home: Home? {
        didSet {
            readmeMd.load(markdown: home?.readme, enableImage: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Anasayfa"
        networkManager.getReadme { (home, errorMessage) in
            DispatchQueue.main.async { [self] in
                self.home = home!
            }
        }

    }
}
