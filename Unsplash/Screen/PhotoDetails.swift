//
//  PhotoDetails.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 31/8/24.
//

import Flow
import SwiftUI
import UnifiedBlurHash

struct PhotoDetails: View {
    let photo: Photo
    @State var vm: PhotoDetailViewModel
    @Environment(AppRoute.self) var router
    @Environment(Authorization.self) var auth
    @Environment(CurrentUserViewModel.self) var currentUser

    init(photo: Photo) {
        self.photo = photo
        vm = PhotoDetailViewModel(photo: photo)
    }
    
    var isLiked: Bool {
        currentUser.likeds.contains(where: {$0.id == photo.id}) || vm.photo.likedByUser
    }
    
    func like(){
        currentUser.likeds.insert(photo)
        photo.like { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                self.currentUser.likeds.remove(photo)
            }
        }
    }
    
    func unLike(){
        currentUser.likeds.remove(photo)
        photo.like { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                self.currentUser.likeds.insert(photo)
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                UserCard(user: vm.photo.user)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding(.horizontal)
                    .onTapGesture {
                        self.router.navigate(to: .user(user: vm.photo.user))
                    }

                PhotoImageView(photo: vm.photo, size: \.full)
                    .aspectRatio(CGFloat(photo.ratio), contentMode: .fill)
                
                if let full = vm.fullPhoto {
                    VStack(alignment: .leading, spacing: 16) {
                        Stats(full: full)

                        if let des = full.description {
                            Text(des)
                        }

                        ExifCard(full: full)

                        TagList(tags: full.tags)

                        RelatedCollection(relatedCollections: full.relatedCollections)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .toolbar { ToolbarItemGroup(placement: .primaryAction, content: Header) }
        .onAppear(perform: vm.load)
    }

    @ViewBuilder
    func Header() -> some View {
        if(auth.isLogined){
            if isLiked {
                Button(
                    action: self.unLike,
                    label: {
                        Label("Like", systemImage: "heart.fill")
                    }
                )
            } else {
                Button(
                    action: self.like,
                    label: {
                        Label("UnLike", systemImage: "heart")
                    }
                )
            }
            Button(
                action: {},
                label: {
                    Label("Add", systemImage: "plus")
                }
            )
        }

        Button(
            action: {},
            label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }
        )
        Button(
            action: {},
            label: {
                Label("Download", systemImage: "square.and.arrow.down")
            }
        )
    }

    @ViewBuilder
    func ExifCard(full: PhotoFull) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Label(full.createdAt, systemImage: "calendar")

            if let name = full.exif.name {
                Label(name, systemImage: "camera")
            }
            if let exposureTime = full.exif.exposureTime {
                Label(exposureTime, systemImage: "camera")
            }
            if let aperture = full.exif.aperture {
                Label(aperture, systemImage: "camera.aperture")
            }
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }

    @ViewBuilder
    func Stats(full: PhotoFull) -> some View {
        HFlow(spacing: 32) {
            VStack(alignment: .leading) {
                Text("Views")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Text("\(full.views)")
                    .font(.title3)
                    .bold()
            }
            VStack(alignment: .leading) {
                Text("Downloads")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Text("\(full.downloads)")
                    .font(.title3)
                    .bold()
            }
            if !full.topics.isEmpty {
                VStack(alignment: .leading) {
                    Text("Featured in")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Text(full.topics.map { $0.title }.joined(separator: ", "))
                        .font(.title3)
                        .bold()
                }
            }
        }
    }

    @ViewBuilder
    func RelatedCollection(relatedCollections: RelatedCollections) -> some View {
        Section(
            header: Text("Related collections")
                .bold()
                .font(.title),
            content: {
                VStack(spacing: 24) {
                    ForEach(relatedCollections.results) { collection in
                        CollectionView(collection: collection)
                            .onTapGesture {
                                self.router.navigate(to: .collection(collection: collection))
                            }
                    }
                }
            }
        )
    }

    @ViewBuilder
    func UserCard(user: User) -> some View {
        HStack {
            PhotoImageView(
                strUrl: user.profileImage.large
            )
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(.circle)
            VStack(alignment: .leading, spacing: 0) {
                Text(user.name)
                    .font(.body)
                    .fontWeight(.semibold)
                Text("@\(user.username)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PhotoDetails(photo: Photo.sample)
            .environment(AppRoute())
            .environment(Authorization())
            .environment(CurrentUserViewModel())
    }
}
