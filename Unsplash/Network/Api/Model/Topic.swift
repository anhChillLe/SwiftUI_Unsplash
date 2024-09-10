import Foundation

struct TopicBase: Codable, Hashable, Identifiable {    
    let id: String
    let title: String
    let slug: String
    let visibility: String
}

struct Topic: Codable, Identifiable, Hashable {
    let id: String
    let slug: String
    let title: String
    let description: String?
    let publishedAt: String
    let updatedAt: String
    let startsAt: String
    let endsAt: String?
    let onlySubmissionsAfter: String?
    let visibility: String
    let featured: Bool?
    let totalPhotos: Int
    let currentUserContributions: [String]
    let totalCurrentUserSubmissions: [String:String]?
    let links: Links
    let mediaTypes: [String]
    let status: String
    let owners: [User]
    let coverPhoto: Photo
    let previewPhotos: [PhotoBase]
    
    enum CodingKeys: String, CodingKey {
        case id, slug, title, description, visibility, featured, links, status, owners
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case onlySubmissionsAfter = "only_submissions_after"
        case totalPhotos = "total_photos"
        case currentUserContributions = "current_user_contributions"
        case totalCurrentUserSubmissions = "total_current_user_submissions"
        case mediaTypes = "media_types"
        case coverPhoto = "cover_photo"
        case previewPhotos = "preview_photos"
    }
}

struct TopicFull: Codable,Hashable, Identifiable {
    let id: String
    let slug: String
    let title: String
    let description: String?
    let publishedAt: String
    let updatedAt: String
    let startsAt: String
    let endsAt: String?
    let onlySubmissionsAfter: String?
    let visibility: String
    let featured: Bool?
    let totalPhotos: Int
    let currentUserContributions: [String]
    let totalCurrentUserSubmissions: [String:String]?
    let links: Links
    let mediaTypes: [String]
    let status: String
    let owners: [User]
    let coverPhoto: Photo
    let previewPhotos: [PhotoBase]
    let topContributors: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case id, slug, title, description, visibility, featured, links, status, owners
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case onlySubmissionsAfter = "only_submissions_after"
        case totalPhotos = "total_photos"
        case currentUserContributions = "current_user_contributions"
        case totalCurrentUserSubmissions = "total_current_user_submissions"
        case mediaTypes = "media_types"
        case coverPhoto = "cover_photo"
        case previewPhotos = "preview_photos"
        case topContributors = "top_contributors"
    }
}
