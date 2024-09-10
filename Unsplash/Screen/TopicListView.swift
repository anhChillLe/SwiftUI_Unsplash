//
//  TopicListView.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 5/9/24.
//

import SwiftUI

struct TopicListView: View {
    @Environment(AppRoute.self) var router
    @Environment(PhotoViewModel.self) var vm

    func openDetail() {}

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(
                        .adaptive(
                            minimum: 300,
                            maximum: .infinity
                        ),
                        spacing: 8
                    ),
                ],
                spacing: 8,
                content: {
                    ForEach(vm.topic.topics) { topic in
                        let openDetail = { router.navigate(to: .topic(topic: topic)) }
                        TopicView(topic: topic)
                            .onTapGesture(perform: openDetail)
                    }
                }
            )
            .padding()
        }
        .navigationTitle("Topic")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
