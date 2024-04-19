//
//  ContentView.swift
//  ios-assignment-abhishekbagela
//
//  Created by Abhishek Bagela on 15/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    let gridColumns: [GridItem] = Array(repeating: GridItem(.fixed(100), spacing: 25, alignment: .center), count: 3)
    
    var body: some View {
        VStack {
            ScrollView {
                if (viewModel.loading) {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    LazyVGrid(columns: gridColumns, spacing: 25) {
                        ForEach(viewModel.models ?? [Model()], id: \.id) { model in
                            ImageView(model)
                        }
                    }
                }
            }
        }
        .navigationTitle("Images")
        .task {
            await viewModel.getData()
        }
        .refreshable {
            await viewModel.refreshData()
        }
    }
}

#Preview {
    ContentView()
}
