//
//  CollectionFullView.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 2/9/24.
//

import Flow
import SwiftUI
import UnifiedBlurHash

struct CollectionView: View {
    let collection: Collection

    @ViewBuilder
    func GridItemsBuilder(_ photos: [PhotoBase], axis: Axis = .horizontal, spacing: CGFloat = 0) -> some View {
        if photos.isEmpty {
            EmptyView() // Trường hợp mảng rỗng
        } else {
            let photo = photos[0]
            let res = Array(photos[1...])

            Grid(horizontalSpacing: spacing, verticalSpacing: spacing) {
                GridRow {
                    PhotoImageView(photo: photo, size: \.small)
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()
                        .gridCellColumns(res.count > 1 ? 2 : 1)
                    if axis == .horizontal {
                        if !res.isEmpty {
                            AnyView(GridItemsBuilder(res, axis: .vertical, spacing: spacing))
                        }
                    }
                }
                if axis == .vertical {
                    if !res.isEmpty {
                        AnyView(GridItemsBuilder(res, axis: .horizontal, spacing: spacing))
                    }
                }
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            GridItemsBuilder(collection.previewPhotos, axis: .horizontal, spacing: 2)
                .cornerRadius(8)
                .aspectRatio(/*@START_MENU_TOKEN@*/1.5/*@END_MENU_TOKEN@*/, contentMode:.fit)

            Text(collection.title)
                .font(.title3)
                .bold()
            Text("\(collection.totalPhotos) images · \(collection.user.name)")
                .font(.body)
                .foregroundStyle(.secondary)
            HFlow(spacing: 8) {
                ForEach(collection.tags) { tag in
                    Button(tag.title) {}
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                        .buttonBorderShape(.roundedRectangle)
                }
            }
        }
    }
}

#Preview {
    CollectionView(
        collection: Collection.sample
    ).padding()
}
