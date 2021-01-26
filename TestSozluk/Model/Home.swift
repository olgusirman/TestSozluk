//
//  Home.swift
//  TestSozluk
//
//  Created by MESUT GUNES on 9.01.2021.
//  Copyright © 2021 MesutGunes. All rights reserved.
//

import Foundation

struct Home: Codable {
    var readme: String
    
    init(readme: String) {
        self.readme = readme
    }
}

