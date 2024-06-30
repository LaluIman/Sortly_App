//
//  ClothViewModel.swift
//  Sortly
//
//  Created by Lalu Iman Abdullah on 24/06/24.
//



import SwiftUI

class ClothingViewModel: ObservableObject {
    @Published var clothingItems: [ClothingItem] = []
    @Published var categories: [String] = ClothingType.allCases.map { $0.rawValue }

    init() {
        loadItems()
    }

    func addItem(name: String, type: ClothingType, imageData: Data?) {
        let newItem = ClothingItem(id: UUID(), name: name, type: type, imageData: imageData)
        clothingItems.append(newItem)
        saveItems()
    }

    func updateItem(item: ClothingItem) {
        if let index = clothingItems.firstIndex(where: { $0.id == item.id }) {
            clothingItems[index] = item
            saveItems()
        }
    }

    func deleteItem(id: UUID) {
        clothingItems.removeAll { $0.id == id }
        saveItems()
    }

    func saveItems() {
        if let data = try? JSONEncoder().encode(clothingItems) {
            UserDefaults.standard.set(data, forKey: "clothingItems")
        }
    }

    func loadItems() {
        if let data = UserDefaults.standard.data(forKey: "clothingItems"),
           let items = try? JSONDecoder().decode([ClothingItem].self, from: data) {
            clothingItems = items
        }
    }

}


