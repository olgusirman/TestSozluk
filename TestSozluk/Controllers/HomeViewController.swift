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
import SafariServices


final class HomeViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    // MARK: Properties

    @IBOutlet weak var dictionaryImg: UIImageView!
    @IBOutlet var readmeMd: MarkdownView!

    private var home: Home? {
        didSet {
            readmeMd.load(markdown: home?.readme, enableImage: false)

            self.readmeMd.onTouchLink = { [weak self] request in
              guard let url = request.url else { return false }

              if url.scheme == "file" {
                return false
              } else if url.scheme == "https" {
                let safari = SFSafariViewController(url: url)
                self?.navigationController?.pushViewController(safari, animated: true)
                return false
              } else {
                return false
              }
            }

        }
    }


    override func viewDidLoad() {
        title = "Anasayfa"
        
        networkManager.getReadme { (home, errorMessage) in
            DispatchQueue.main.async { [self] in
                self.home = home!
            }
        }

        self.readmeMd.onTouchLink = { [weak self] request in
          guard let url = request.url else { return false }

          if url.scheme == "file" {
            return true
          } else if url.scheme == "https" {
            let safari = SFSafariViewController(url: url)
            self?.present(safari, animated: true, completion: nil)
            return false
          } else {
            return false
          }
        }
    }
}
