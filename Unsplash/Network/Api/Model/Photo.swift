import Foundation

struct PhotoBase: Hashable, Codable, Identifiable {
    let id: String
    let slug: String
    let createdAt: String
    let updatedAt: String
    let blurHash: String?
    let assetType: String
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case blurHash = "blur_hash"
        case assetType = "asset_type"
        case urls
    }
}

struct Photo: Hashable, Codable, Identifiable {
    let id: String
    let slug: String
    let createdAt: String
    let updatedAt: String
    let blurHash: String?
    let assetType: String
    let urls: Urls
    let alternativeSlugs: [String: String]
    let promotedAt: String?
    let width: Int
    let height: Int
    let color: String
    let description: String?
    let altDescription: String?
    let breadcrumbs: [Breadcrumb]
    let links: Links
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [String]
    let sponsorship: Sponsorship?
    let topicSubmissions: [String: Submition]?
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case blurHash = "blur_hash"
        case assetType = "asset_type"
        case urls
        case width
        case height
        case color
        case description
        case breadcrumbs
        case links
        case likes
        case sponsorship
        case user
        case alternativeSlugs = "alternative_slugs"
        case promotedAt = "promoted_at"
        case altDescription = "alt_description"
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case topicSubmissions = "topic_submissions"
    }
    
    var ratio: Float {
        Float(width) / Float(height)
    }
}

struct PhotoFull: Codable, Identifiable, Hashable {
    let id: String
    let slug: String
    let alternativeSlugs: [String: String]
    let createdAt: String
    let updatedAt: String
    let promotedAt: String?
    let blurHash: String?
    let assetType: String
    let urls: Urls
    let width: Int
    let height: Int
    let color: String
    let description: String?
    let altDescription: String?
    let breadcrumbs: [Breadcrumb]
    let links: Links
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [String]
    let sponsorship: Sponsorship?
    let topicSubmissions: [String: Submition]?
    let user: User
    let exif: Exif
    let location: Location?
    let publicDomain: Bool
    let tags: [Tag]
    let tagsPreview: [Tag]
    let views: Int
    let downloads: Int
    let topics: [TopicBase]
    let relatedCollections: RelatedCollections
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case blurHash = "blur_hash"
        case assetType = "asset_type"
        case urls
        case width
        case height
        case color
        case description
        case breadcrumbs
        case links
        case likes
        case sponsorship
        case user
        case alternativeSlugs = "alternative_slugs"
        case promotedAt = "promoted_at"
        case altDescription = "alt_description"
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case topicSubmissions = "topic_submissions"
        case exif
        case location
        case publicDomain = "public_domain"
        case tags
        case tagsPreview = "tags_preview"
        case views
        case downloads
        case topics
        case relatedCollections = "related_collections"
    }
    
    var ratio: Float {
        Float(width) / Float(height)
    }
}
