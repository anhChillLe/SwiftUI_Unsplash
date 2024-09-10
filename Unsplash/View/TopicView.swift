//
//  CollectionFullView.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 2/9/24.
//

import Flow
import SwiftUI
import UnifiedBlurHash

struct TopicView: View {
    let topic: Topic

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(topic.title)
                    .font(.title3)
                    .bold()
//                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                HStack {
                    Text("by")
                        .foregroundStyle(.secondary)
                    Text(topic.owners.map { $0.name }.joined(separator: ", "))
                        .fontWeight(.medium)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .foregroundStyle(Color.textColor(for: Color(hex: topic.coverPhoto.color)))

            GeometryReader { proxy in
                let height = proxy.size.height
                HStack(alignment: .bottom, spacing: 0) {
                    PhotoImageView(photo: topic.previewPhotos[0], size: \.thumb)
                        .scaledToFill()
                        .frame(width: height * 0.75, height: height)
                        .clipped()
                        .overlay(
                            Rectangle()
                                .frame(width: 2)
                                .foregroundStyle(.background),
                            alignment: .leading
                        )
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.background),
                            alignment: .top
                        )
                        .overlay(
                            Rectangle()
                                .frame(width: 2)
                                .foregroundStyle(.background),
                            alignment: .trailing
                        )
                    PhotoImageView(photo: topic.previewPhotos[1], size: \.thumb)
                        .scaledToFill()
                        .frame(width: height * 0.75, height: height * 0.75)
                        .clipped()
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.background),
                            alignment: .top
                        )
                        .overlay(
                            Rectangle()
                                .frame(width: 2)
                                .foregroundStyle(.background),
                            alignment: .trailing
                        )
                }.frame(width: proxy.size.width)
            }.aspectRatio(2.25, contentMode: .fit)
        }
        .padding(.horizontal)
        .padding(.top)
        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        .background(content: Background)
        .cornerRadius(16)
    }
    
    @ViewBuilder
    func Background() -> some View {
        if let blurHash = topic.coverPhoto.blurHash {
            Image(blurHash: blurHash)?
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

        } else {
            Color(hex: topic.coverPhoto.color)
        }
    }
}

#Preview {
    VStack {
        TopicView(
            topic: Topic.samples[5]
        )
        .frame(width: 250)
        .padding()
        TopicView(
            topic: Topic.samples[2]
        )
        .frame(width: 250)
        .padding()
    }
}
