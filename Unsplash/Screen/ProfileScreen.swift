//
//  ProfileScreen.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 28/8/24.
//

import Flow
import SwiftUI

struct ProfileScreen: View {
    @Environment(Authorization.self) var authorization
    @AppStorage("profile") var userWrapper: CodableWrapper<CurrentUser?> = .init(value: nil)

    var body: some View {
        VStack {
            if let user = userWrapper.value {
                UserCard(user: user)
            } else {
                EmptyUserCard()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(
                    colors: [Color.accentColor.opacity(0.25), .clear]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

private struct EmptyUserCard: View {
    @Environment(Authorization.self) var authorization
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: "person")
                .font(.largeTitle)
                .foregroundStyle(.accent)
                .padding(24)
                .background(.background)
                .clipShape(.buttonBorder)
            Button(
                action: authorization.requestCode,
                label: {
                    Label("Login with Unsplash", image: "unsplash")
                }
            )
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
    }
}

private struct UserCard: View {
    let user: CurrentUser
    @Environment(Authorization.self) var auth
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                PhotoImageView(strUrl: user.profileImage.large)
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                .clipShape(.circle)
                Button("Logout", action: auth.logout)
                    .buttonStyle(.bordered)
            }

            Text(user.name)
                .font(.title)
                .bold()
            Text(user.bio)
            Label(user.location, systemImage: "location")
                .foregroundStyle(.secondary)
            SocialCard()

            Stats()
                .fixedSize()
        }
    }

    @ViewBuilder
    func Stats() -> some View {
        HStack(spacing: 24) {
            VStack(alignment: .leading) {
                Text("Collections")
                    .foregroundStyle(.secondary)
                Text("\(user.totalCollections)")
                    .bold()
                    .font(.title3)
            }
            Divider()
            VStack(alignment: .leading) {
                Text("Photos")
                    .foregroundStyle(.secondary)
                Text("\(user.totalPhotos)")
                    .bold()
                    .font(.title3)
            }
            Divider()
            VStack(alignment: .leading) {
                Text("Likes")
                    .foregroundStyle(.secondary)
                Text("\(user.totalLikes)")
                    .bold()
                    .font(.title3)
            }
        }
    }

    @ViewBuilder
    func TagList() -> some View {
        let tags = user.tags.aggregated
        HFlow {
            ForEach(tags) { tag in
                Button(tag.title) {}
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                    .buttonBorderShape(.roundedRectangle)
            }
        }
    }

    @ViewBuilder
    func SocialCard() -> some View {
        let social = user.social
        if let instagram = social.instagramUsername {
            Label(instagram, systemImage: "camera")
        }
        if let portfolio = social.portfolioUrl {
            Label(portfolio, systemImage: "camera")
        }
        if let twitter = social.twitterUsername {
            Label(twitter, systemImage: "camera")
        }
        if let paypal = social.paypalEmail {
            Label(paypal, systemImage: "camera")
        }
    }
}

#Preview {
    ProfileScreen()
        .environment(Authorization())
//    EmptyUserCard()
//        .environment(Authorization())
//    UserCard(user: CurrentUser.sample)
}
