//
//  Extension.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 4/9/24.
//

import Foundation

#if DEBUG
extension Photo {
    static let samples: [Photo] = load("PhotoSamples.json")
    static let sample = samples[0]
}

extension Topic {
    static let samples: [Topic] = load("TopicSamples.json")
    static let sample = samples[0]
}

extension Collection {
    static let samples: [Collection] = load("CollectionSamples.json")
    static let sample = samples[0]
}

extension CurrentUser {
    static let sample: CurrentUser = load("CurrentUserSample.json")
}

extension UserFull {
    static let sample: Self = load("UserSample.json")
}
#endif
