//
//  StateData.swift
//  Pocket Fauci
//
//  Created by Chris Bond on 4/16/22.
//

import Foundation


struct StateData: Codable {
    var state: String
    var positive: Int
    var hospitalizedCurrently: Int?
    var death: Int
}
