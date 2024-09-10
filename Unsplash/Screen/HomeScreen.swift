//
//  HomeScreen.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 28/8/24.
//

import Alamofire
import SwiftUI

struct HomeScreen: View {
    @Environment(PhotoViewModel.self) var vm
    @Environment(AppRoute.self) var router
    @State var searchValue = ""

    var body: some View {
        ScrollView {
            TopicSection()
            CollectionSection()
            PhotoSection()
        }
        .safeAreaInset(edge: .top, content: Header)
        .contentMargins(16, for: .scrollContent)
    }
    
    @ViewBuilder
    func Header() -> some View {
        VStack {
            SearchBar(text: $searchValue)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .background(.regularMaterial)
    }
    
    @ViewBuilder
    func PhotoSection() -> some View {
        Section(
            header: HStack {
                Text("Photo")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Button("More") {
                    router.navigate(to: .listPhoto)
                }
            },
            content: {
                VStack {
                    PhotoGrid(
                        photos: vm.latest.photos,
                        spacing: 8,
                        onLastItemApear: vm.latest.next
                    )
                    ProgressView()
                        .onAppear(perform: vm.latest.next)
                }
            }
        )
    }
    
    @ViewBuilder
    private func CollectionSection() -> some View {
        Section(
            header: HStack {
                Text("Collection")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Button("More") {
                    router.navigate(to: .listCollection)
                }
            },
            content: {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(vm.collection.collections) { collection in
                            TextOnBlurItem(collection.title, photo: collection.coverPhoto)
                                .onTapGesture {
                                    router.navigate(to: .collection(collection: collection))
                                }
                        }
                    }.scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
            }
        )
    }

    @ViewBuilder
    private func TopicSection() -> some View {
        Section(
            header: HStack {
                Text("Topic")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Button("More") {
                    router.navigate(to: .listTopic)
                }
            },
            content: {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(vm.topic.topics) { topic in
                            TextOnBlurItem(topic.title, photo: topic.coverPhoto)
                                .onTapGesture {
                                    router.navigate(to: .topic(topic: topic))
                                }
                        }
                    }.scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
            }
        )
    }
    
    @ViewBuilder
    private func TextOnBlurItem(_ text: String, photo: Photo) -> some View {
        ZStack {
            Group {
                if let blurHash = photo.blurHash {
                    Image(blurHash: blurHash)?
                        .resizable()
                } else {
                    Color(hex: photo.color)
                }
            }
            .scaledToFill()
            .frame(minWidth: 150, minHeight: 150)
            .clipped()
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(8)
            .layoutPriority(1)
            
            Text(text)
                .foregroundStyle(Color.textColor(for: Color(hex: photo.color)))
                .font(.body)
                .bold()
                .padding(4)
        }
    }
}

#Preview {
    ContentView()
}
