//
//  AddView.swift
//  Sortly
//
//  Created by Lalu Iman Abdullah on 24/06/24.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var viewModel: ClothingViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var type: ClothingType = .casual
    @State private var imageData: Data?
    @State private var showingImagePicker = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name of the clothes", text: $name)
                }
                Section(header: Text("Type")) {
                    HStack {
                        Picker("Type", selection: $type) {
                            ForEach(ClothingType.allCases) { type in
                                Text(type.rawValue.capitalized).tag(type)
                            }
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
                        Text("Select Image")
                    }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(imageData: $imageData)
                    }
                }
            }
            .navigationBarItems(
                trailing:
                Button {
                    viewModel.addItem(name: name, type: type, imageData: imageData)
                    presentationMode.wrappedValue.dismiss()
                   } label: {
                       HStack {
                           Text("Add data")
                           Image(systemName: "plus")
                       }
                   }
            )
        }
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ClothingViewModel()
        return AddView(viewModel: viewModel)
    }
}
