//
//  Item.swift
//  Lab 1 CV
//
//  Created by Kevin Lim on 21/1/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
