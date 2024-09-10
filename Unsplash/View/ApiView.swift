//
//  ApiView.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 10/9/24.
//

import Alamofire
import SwiftUI

struct ApiView<T: Codable, Idle: View, Loading: View, Success: View, Failure: View>: View {
    let state: APIState<T>
    var idle: () -> Idle
    var loading: () -> Loading
    var success: (T) -> Success
    var failure: (AFError) -> Failure

    init(
        _ state: APIState<T>,
        idle: @escaping () -> Idle = { ProgressView() },
        loading: @escaping () -> Loading = { ProgressView() },
        failure: @escaping (AFError) -> Failure = { error in Text(error.localizedDescription) },
        success: @escaping (T) -> Success
    ) {
        self.state = state
        self.idle = idle
        self.loading = loading
        self.failure = failure
        self.success = success
    }

    var body: some View {
        switch state {
        case .idle:
            idle()
        case .loading:
            loading()
        case let .success(data):
            success(data)
        case let .failure(error):
            failure(error)
        }
    }
}
