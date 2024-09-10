//
//  CollectionDetails.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 5/9/24.
//

import SwiftUI
import Flow

struct CollectionDetails: View {
    @State var vm: CollectionDetailViewModel
    
    init(collection: Collection) {
        self.vm = CollectionDetailViewModel(collection: collection)
    }
    
    var collection: Collection { vm.collection }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                PhotoImageView(photo: collection.coverPhoto, size: \.full)
                    .aspectRatio(CGFloat(collection.coverPhoto.ratio), contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                Group {
                    UserCard()
                    Text(collection.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                    if let des = collection.description {
                        Text(des)
                            .font(.body)
                    }
                    TagList()
                    HStack {
                        Text("\(collection.totalPhotos) images")
                            .bold()
                        Spacer()
                        Button(
                            action: {},
                            label: {
                                Label("Share", systemImage: "square.and.arrow.up")
                            }
                        )
                    }
                    .padding(.vertical)
                    PhotoGrid(photos: vm.photos, spacing: 8)
                }.padding(.horizontal)
            }
        }.onAppear(perform: vm.loadPhoto)
    }
    
    
    @ViewBuilder
    func TagList() -> some View {
        HFlow(spacing: 8) {
            ForEach(collection.tags){ tag in
                Button(tag.title){}
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                    .buttonBorderShape(.roundedRectangle)
            }
        }
    }
    
    @ViewBuilder
    func UserCard() -> some View {
        let user = collection.user
        HStack {
            PhotoImageView(strUrl: user.profileImage.large)
                .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 48)
                .clipShape(.circle)
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.body)
                    .bold()
                Text("@\(user.username)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        CollectionDetails(collection: Collection.samples[6])
    }.environment(AppRoute())
}
