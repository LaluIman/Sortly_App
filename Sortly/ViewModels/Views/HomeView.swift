//
//  HomeView.swift
//  Sortly
//
//  Created by Lalu Iman Abdullah on 24/06/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ClothingViewModel()
    @State private var selectedType: ClothingType = .casual
    @State private var showingAddView = false
    @State private var showingDeleteAlert = false
    @State private var itemToDelete: ClothingItem?
    
   
    static let color0 = Color(red: 135/255, green: 202/255, blue: 255/255);
         
    static let color1 = Color(red: 65/255, green: 171/255, blue: 255/255);
           

    let gradient = Gradient(colors: [color0, color1]);
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ZStack {
                        //hero section
                        Rectangle()
                            .fill(RadialGradient(
                                gradient: gradient,
                                center: .center,
                                startRadius: 100,
                                endRadius: 200
                              ))
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .offset(y: -10)
                            .ignoresSafeArea()
                            .padding(.bottom, -10)
                        VStack {
                            VStack {
                                Text("Welcome to")
                                    .foregroundStyle(.white)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, -35)
                                Text("Sortly")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 45, weight: .black))
                                    .tracking(6)
                            }
                            .offset(y: 60)
                            .padding(.top, 20)
                            Image("Clothes")
                                .resizable()
                                .frame(width: 345,height: 290)
                                .padding(.top, 20)
                        }
                    }
                    .frame(width: 400)
                    .frame(height: 420)
                    // Calculation boxes & selection
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack (spacing: 2){
                            ForEach(ClothingType.allCases) { type in
                                Button(action: {
                                    selectedType = type
                                }) {
                                    VStack {
                                        Text("\(viewModel.clothingItems.filter { $0.type == type }.count)")
                                            .font(.largeTitle)
                                            .bold()
                                            .foregroundColor(selectedType == type ? .white : .cyan)
                                        Text(type.rawValue.capitalized)
                                            .fontWeight(.semibold)
                                            .foregroundColor(selectedType == type ? .white : .cyan)
                                    }
                                    .frame(width: 100, height: 80)
                                    .background(selectedType == type ? Color("C1") : Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .padding(5)
                                    .shadow(radius: selectedType == type ? 0 : 2)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                    //data
                    let filteredItems = viewModel.clothingItems.filter { $0.type == selectedType }
                    VStack(spacing: 10) {
                        if filteredItems.isEmpty {
                            VStack {
                                Text("No data here!")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                Image(systemName: "xmark.bin.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.gray)
                                    .padding(1)
                            }
                        } else {
                            ForEach(filteredItems) { item in
                                HStack {
                                    NavigationLink(destination: DetailView(item: item, viewModel: viewModel)) {
                                    if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 55, height: 55)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                    }
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .foregroundStyle(.cyan)
                                            .font(.system(size: 20, weight: .bold))
                                        Text(item.type.rawValue).font(.subheadline).foregroundColor(.gray)
                                    }
                                    Spacer()
                                    }
                                    Button(action: {
                                        itemToDelete = item
                                        showingDeleteAlert = true
                                    }) {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding()
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                                .shadow(radius: 1)
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 60)
                }
            }
            //add button
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddView(viewModel: viewModel)) {
                            Image(systemName: "plus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(LinearGradient(
                                    gradient: gradient,
                                    startPoint: .bottomTrailing,
                                    endPoint: .topLeading
                                  )
                                )
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                }, alignment: .bottomTrailing
            )
            .padding(.bottom)
            .ignoresSafeArea()
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Delete Item"),
                    message: Text("Are you sure you want to delete this item?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let item = itemToDelete {
                            viewModel.deleteItem(id: item.id)
                            itemToDelete = nil
                        }
                    },
                    secondaryButton: .cancel {
                        itemToDelete = nil
                    }
                )
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
