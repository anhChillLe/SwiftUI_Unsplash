//
//  PhotoImageView.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 2/9/24.
//

import Kingfisher
import NukeUI
import SwiftUI
import UnifiedBlurHash

struct PhotoImageView: View {
    let url: URL?
    let blurHash: String?
    let color: String?

    init(strUrl: String, blurHash: String? = nil) {
        self.url = URL(string: strUrl)
        self.blurHash = blurHash
        self.color = nil
    }

    init(photo: Photo, size path: KeyPath<Urls, String> = \.regular) {
        url = URL(string: photo.urls[keyPath: path])
        blurHash = photo.blurHash
        self.color = photo.color
    }

    init(photo: PhotoBase, size path: KeyPath<Urls, String> = \.regular) {
        url = URL(string: photo.urls[keyPath: path])
        blurHash = photo.blurHash
        self.color = nil
    }

    init(photo: PhotoFull, size path: KeyPath<Urls, String> = \.regular) {
        url = URL(string: photo.urls[keyPath: path])
        blurHash = photo.blurHash
        self.color = photo.color
    }

    var body: some View {
        KFImage(url)
            .placeholder(blurHash: blurHash)
            .resizable()
    }
}

#Preview {
    PhotoImageView(photo: Photo.sample)
        .scaledToFill()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .clipped()
        .aspectRatio(1, contentMode: .fit)
}
