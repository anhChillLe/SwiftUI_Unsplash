//
//  User.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 28/8/24.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: String
    let updatedAt: String
    let username: String
    let name:  String
    let firstName: String
    let lastName: String?
    let bio: String?
    let location: String?
    let links: Links
    let social: Social
    let profileImage: ProfileImage
    let twitterUsername: String?
    let portfolioUrl: String?
    let instagramUsername: String?
    let totalCollections: Int
    let totalLikes: Int
    let totalPhotos: Int
    let totalPromoted_photos: Int
    let totalIllustrations: Int
    let acceptedTos: Bool
    let forHire: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, username, name, bio, location, social, links
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioUrl = "portfolio_url"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalPromoted_photos = "total_promoted_photos"
        case totalIllustrations = "total_illustrations"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        case profileImage = "profile_image"
    }
}

struct UserFull: Codable, Hashable, Identifiable {
    let id: String
    let updatedAt: String
    let username: String
    let name:  String
    let firstName: String
    let lastName: String?
    let bio: String?
    let location: String?
    let links: Links
    let social: Social
    let profileImage: ProfileImage
    let twitterUsername: String?
    let portfolioUrl: String?
    let instagramUsername: String?
    let totalCollections: Int
    let totalLikes: Int
    let totalPhotos: Int
    let totalPromoted_photos: Int
    let totalIllustrations: Int
    let acceptedTos: Bool
    let forHire: Bool
    let followedByUser: Bool
    let photos: [PhotoBase]
    let badge: Badge?
    let tags: Tags
    let followersCount: Int
    let followingCount: Int
    let allowMessages: Bool
    let numericId: Int
    let downloads: Int
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case id
        case username, name, bio, location, social, links, photos, badge, tags, downloads, meta
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioUrl = "portfolio_url"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalPromoted_photos = "total_promoted_photos"
        case totalIllustrations = "total_illustrations"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        case profileImage = "profile_image"
        case followedByUser = "followed_by_user"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case allowMessages = "allow_messages"
        case numericId = "numeric_id"
    }
}
