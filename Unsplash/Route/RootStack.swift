//
//  RootStack.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 5/9/24.
//

import Foundation
import SwiftUI

struct RootStack: View {
    @State var router = AppRoute()
    @Environment(Authorization.self) var auth

    var body: some View {
        NavigationStack(path: $router.path) {
            MainTab()
                .navigationDestination(for: AppRoute.Route.self) { route in
                    switch route {
                    case let .photo(photo):
                        PhotoDetails(photo: photo)
                    case let .collection(collection):
                        CollectionDetails(collection: collection)
                    case let .topic(topic):
                        TopicDetails(topic: topic)
                    case let .user(user):
                        UserDetails(user: user)
                    case .listPhoto:
                        PhotoListView()
                    case .listCollection:
                        CollectionListView()
                    case .listTopic:
                        TopicListView()
                    }
                }
        }
        .environment(router)
    }
}
