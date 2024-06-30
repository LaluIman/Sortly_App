//
//  ClothModel.swift
//  Sortly
//
//  Created by Lalu Iman Abdullah on 24/06/24.
//

import SwiftUI

struct ClothingItem: Identifiable, Codable {
    var id: UUID
    var name: String
    var type: ClothingType
    var imageData: Data?
}

