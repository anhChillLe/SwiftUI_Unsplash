import Flow
import SwiftUI

struct UserDetails: View {
    @State var vm: UserDetailViewModel

    init(user: User) {
        vm = UserDetailViewModel(user: user)
    }

    var body: some View {
        ApiView(vm.apiState) { full in
            UserDetailLayout(user: full)
        }.onAppear(perform: vm.getProfile)
    }
}

struct UserDetailLayout: View {
    let user: UserFull

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .bottom) {
                    PhotoImageView(strUrl: user.profileImage.large)
                        .scaledToFill()
                        .frame(width: 128, height: 128)
                        .clipShape(.circle)
                        .overlay(
                            Circle()
                                .stroke(Color.accentColor, lineWidth: 2)
                                .padding(1)
                        )
                    Spacer()
                    if user.followedByUser {
                        Menu(
                            content: {
                                Button("Unfollow", action: {})
                                    .buttonStyle(.borderedProminent)
                            },
                            label: {
                                Button(
                                    action: {},
                                    label: {
                                        Label("Followed", systemImage: "checkmark")
                                    }
                                )
                                .buttonStyle(.borderedProminent)
                            }
                        )
                    } else {
                        Button(
                            action: {},
                            label: {
                                Label("Follow", systemImage: "plus")
                            }
                        )
                        .buttonStyle(.borderedProminent)
                    }
                }

                Text(user.name)
                    .font(.title)
                    .bold()

                if let bio = user.bio {
                    Text(bio)
                }

                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Followers")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text("\(user.followersCount)")
                            .fontWeight(.semibold)
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        Text("Following")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text("\(user.followingCount)")
                            .fontWeight(.semibold)
                    }
                }

                VStack(alignment: .leading) {
                    if let location = user.location {
                        Button(
                            action: {},
                            label: {
                                Label(location, systemImage: "location")
                            }
                        )
                    }
                    SocialView()
                }
                    .padding(.vertical, 4)

                Section(
                    content: {
                        TagList(tags: user.tags.custom)
                    },
                    header: {
                        Text("Interests")
                            .fontWeight(.medium)
                    }
                )
                
                

            }.padding()
        }
        .toolbar {
            ToolbarItemGroup(content: ToolbarContent)
        }
    }
    
    @ViewBuilder
    func ToolbarContent() -> some View {
        Menu(
            content: {
                Button("Follow \(user.name)", action: {})

                Button("Share profile", action: {})

                Button("Report", role: .destructive, action: {})
            },
            label: {
                Image(systemName: "ellipsis")
            }
        )
    }
    
    @ViewBuilder
    func SocialView() -> some View {
        let social = user.social
        if !social.connectable {
            EmptyView()
        }
        Menu(
            content: {
                if social.portfolioUrl != nil {
                    Button(
                        action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/,
                        label: {
                            Label("Portfolio", systemImage: "network")
                                .lineLimit(1)
                        }
                    )
                }

                if social.twitterUsername != nil {
                    Button(
                        action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/,
                        label: {
                            Label("Twitter", image: "twitter")
                        }
                    )
                }

                if social.instagramUsername != nil {
                    Button(
                        action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/,
                        label: {
                            Label("Instagram", image: "instagram")
                        }
                    )
                }
                if social.paypalEmail != nil {
                    Button(
                        action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/,
                        label: {
                            Label("Paypal", image: "paypal")
                        }
                    )
                }
            },
            label: {
                Label("Connect with \(user.name)", systemImage: "link")
            }
        )
    }
}

#Preview {
    NavigationStack {
        UserDetailLayout(user: UserFull.sample)
    }
}
