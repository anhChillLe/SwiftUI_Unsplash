//
//  SearchBar.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 1/9/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
            TextField("Search something", text: $text)
            if !text.isEmpty {
                Image(systemName: "xmark")
            }
        }
        .padding()
        .background(.background)
        .cornerRadius(12)
    }
}

#Preview {
    @State var text: String = ""
    return VStack {
        SearchBar(text: $text).padding()
    }
}
