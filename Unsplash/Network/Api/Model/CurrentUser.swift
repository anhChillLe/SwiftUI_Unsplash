import Foundation

struct CurrentUser: Codable, Identifiable, Hashable {
    let id: String
    let updatedAt: String
    let username: String
    let name: String
    let firstName: String
    let lastName: String
    let twitterUsername: String?
    let portfolioUrl: String?
    let bio: String
    let location: String
    let links: Links
    let profileImage: ProfileImage
    let instagramUsername: String?
    let totalCollections: Int
    let totalLikes: Int
    let totalPhotos: Int
    let totalPromotedPhotos: Int
    let totalIllustrations: Int
    let totalPromotedIllustrations: Int
    let acceptedTos: Bool
    let forHire: Bool
    let social: Social
    let followedByUser: Bool
    let photos: [Photo]
    let badge: Badge?
    let tags: Tags
    let followersCount: Int
    let followingCount: Int
    let allowMessages: Bool
    let numericId: Int
    let downloads: Int
    let meta: Meta
    let uid: String
    let confirmed: Bool
    
    struct Links: Codable, Hashable {
        let me: String
        let html: String
        let photos: String
        let likes: String
        let portfolio: String
        let following: String
        let followers: String
        
        enum CodingKeys: String, CodingKey {
            case me = "self"
            case html
            case photos
            case likes
            case portfolio
            case following
            case followers
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioUrl = "portfolio_url"
        case bio
        case location
        case links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalPromotedPhotos = "total_promoted_photos"
        case totalIllustrations = "total_illustrations"
        case totalPromotedIllustrations = "total_promoted_illustrations"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        case social
        case followedByUser = "followed_by_user"
        case photos
        case badge
        case tags
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case allowMessages = "allow_messages"
        case numericId = "numeric_id"
        case downloads
        case meta
        case uid
        case confirmed
    }
}

