//
//  TagList.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 10/9/24.
//

import SwiftUI
import Flow

struct TagList: View {
    let tags: [Tag]
    var body: some View {
        HFlow {
            ForEach(tags) { tag in
                Button(tag.title, action: {})
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                    .buttonBorderShape(.roundedRectangle)
                    .foregroundStyle(.primary)
            }
        }
    }
}

//#Preview {
//    TagList()
//}
