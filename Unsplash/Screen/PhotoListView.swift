//
//  PhotoView.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 2/9/24.
//

import SwiftUI

struct PhotoListView: View {
    @State var selection: Int = 0
    @Environment(PhotoViewModel.self) var vm
    
    var body: some View {
        TabView(selection: $selection.animation()) {
            PhotoPage(photos: vm.latest.photos)
                .tag(0)
            PhotoPage(photos: vm.oldest.photos)
                .tag(1)
            PhotoPage(photos: vm.popular.photos)
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .safeAreaInset(edge: .top) {
            TopTab(
                tabs: ["Latest", "Oldest", "Popular"],
                currentTab: $selection
            )
        }
        .contentMargins(.bottom, 64, for: .scrollContent)
        .padding(.horizontal)
    }
}

struct TopTab: View {
    @Namespace private var animation
    var tabs: [String]
    @Binding var currentTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabs.enumerated()), id: \.element.self){ index, label in
                TabItem(label: label, isSelected: currentTab == index)
                    .onTapGesture {
                        withAnimation {
                            currentTab = index
                        }
                    }
            }
        }
        .overlay(alignment: .bottom){
            RoundedRectangle(cornerRadius: 2)
                .fill(.gray)
                .frame(height: 2)
                .opacity(0.1)
        }
    }
    
    @ViewBuilder
    func TabItem(label: String, isSelected: Bool) -> some View {
        Text(label)
            .fontWeight(.semibold)
            .lineLimit(1)
            .padding(.vertical, 12)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .foregroundStyle(isSelected ? .accent : .secondary)
            .overlay(alignment: .bottom){
                if isSelected {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.accent)
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "selection", in: animation)
                } else {
                    Color.clear
                }
            }
    }
}

struct PhotoPage: View {
    let photos: [Photo]
    
    var body: some View {
        ScrollView {
            PhotoGrid(
                photos: photos,
                spacing: 4
            )
        }
    }
}

#Preview {
    ContentView()
}
