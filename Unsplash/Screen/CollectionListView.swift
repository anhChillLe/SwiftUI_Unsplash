//
//  CollectionView.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 4/9/24.
//

import SwiftUI

struct CollectionListView: View {
    @Environment(AppRoute.self) var router
    @Environment(PhotoViewModel.self) var vm
    
    var body: some View {
        List(vm.collection.collections) { collection in
                CollectionView(collection: collection)
                .listRowSeparator(.hidden)
                .onTapGesture {
                    router.navigate(to: .collection(collection: collection))
                }
        }
        .listStyle(.plain)
        .navigationTitle("Collection")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    ContentView()
}
