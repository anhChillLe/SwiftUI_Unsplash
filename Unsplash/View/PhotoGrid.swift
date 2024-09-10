//
//  ImageGrid.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 30/8/24.
//

import SwiftUI

struct PhotoGrid: View {
    @Environment(AppRoute.self) var router
    let photos: [Photo]
    let spacing: CGFloat
    var onLastItemApear: () -> Void

    init(photos: [Photo], spacing: CGFloat = 4, onLastItemApear: @escaping () -> Void = {}) {
        self.photos = photos
        self.spacing = spacing
        self.onLastItemApear = onLastItemApear
    }

    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(
                    .adaptive(
                        minimum: 150,
                        maximum: .infinity
                    ),
                    spacing: spacing
                ),
            ],
            spacing: spacing,
            content: {
                ForEach(photos) { photo in
                    Button(action: { router.navigate(to: .photo(photo: photo)) }) {
                        PhotoImageView(photo: photo, size: \.small)
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .clipped()
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(4)
                            .onAppear {
                                if photo.id == photos.last?.id {
                                    onLastItemApear()
                                }
                            }
                    }
                }
            }
        )
    }
}

#Preview {
    ScrollView {
        PhotoGrid(
            photos: Photo.samples,
            spacing: 4
        ).padding()
    }
    .environment(AppRoute())
}
