//
//  License.swift
//  TestSozluk
//
//  Created by MESUT GUNES on 14.01.2021.
//  Copyright © 2021 MesutGunes. All rights reserved.
//

import Foundation

struct License: Codable {
    var license: String

    init(license: String) {
        self.license = license
    }
}
