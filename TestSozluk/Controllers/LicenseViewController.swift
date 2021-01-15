//
//  LicenseViewController.swift
//  TestSozluk
//
//  Created by MESUT GUNES on 14.01.2021.
//  Copyright © 2021 MesutGunes. All rights reserved.
//

import Foundation
import UIKit

final class LicenseViewController: UIViewController {

    @IBOutlet weak var licenseTv: UITextView!
    private let networkManager = NetworkManager()

    private var license: License? {
        didSet {
            licenseTv.text = license?.license
        }
    }

    override func viewDidLoad() {
        title = "License"

        networkManager.getLicense { (license, errorMessage) in
            DispatchQueue.main.async { [self] in
                self.license = license
            }
        }
    }
}
