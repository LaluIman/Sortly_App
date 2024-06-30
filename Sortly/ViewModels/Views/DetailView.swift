//
//  DetailView.swift
//  Sortly
//
//  Created by Lalu Iman Abdullah on 24/06/24.
//

import SwiftUI

struct DetailView: View {
    var item: ClothingItem
    @ObservedObject var viewModel: ClothingViewModel
    @State private var name: String
    @State private var type: ClothingType
    @State private var imageData: Data?
    @State private var showingImagePicker = false

    init(item: ClothingItem, viewModel: ClothingViewModel) {
        self.item = item
        self.viewModel = viewModel
        _name = State(initialValue: item.name)
        _type = State(initialValue: item.type)
        _imageData = State(initialValue: item.imageData)
    }

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $name)
            }
            Section(header: Text("Type")) {
                Picker("Type", selection: $type) {
                    ForEach(ClothingType.allCases) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
            }
            Section(header: Text("Image")) {
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else {
                    Text("No Image Selected")
                }
                Button(action: {
                    showingImagePicker = true
                }) {
                    Text("Change Image")
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(imageData: $imageData)
                }
            }
        }
        .navigationBarTitle("Edit")
        .navigationBarItems(trailing: Button("Save changes") {
            let updatedItem = ClothingItem(id: item.id, name: name, type: type, imageData: imageData)
            viewModel.updateItem(item: updatedItem)
        })
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ClothingViewModel()
        let sampleItem = ClothingItem(id: UUID(), name: "Sample Shirt", type: .formal, imageData: nil)
        return DetailView(item: sampleItem, viewModel: viewModel)
    }
}
