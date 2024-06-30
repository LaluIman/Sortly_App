//
//  ClothType.swift
//  Sortly
//
//  Created by Lalu Iman Abdullah on 24/06/24.
//

import SwiftUI

enum ClothingType: String, CaseIterable, Identifiable, Codable {
    case casual = "Casual"
    case inside = "Indoor"
    case sport = "Sport"
    case formal = "Formal"
    case uniform = "Uniform"
    
    var id: String { self.rawValue }
}
