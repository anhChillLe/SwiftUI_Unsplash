//
//  Collection.swift
//  Unsplash
//
//  Created by Lê Anh Chiêu on 28/8/24.
//

import Foundation

struct Collection: Codable, Identifiable, Hashable {    
    let id: String
    let title: String
    let description: String?
    let publishedAt: String
    let lastCollectedAt: String
    let updatedAt: String
    let featured: Bool
    let totalPhotos: Int
    let isPrivate: Bool
    let shareKey: String
    let tags: [Tag]
    let links: Links
    let user: User
    let coverPhoto: Photo
    let previewPhotos: [PhotoBase]
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, featured, tags, links, user
        case publishedAt = "published_at"
        case lastCollectedAt = "last_collected_at"
        case updatedAt = "updated_at"
        case totalPhotos = "total_photos"
        case shareKey = "share_key"
        case isPrivate = "private"
        case coverPhoto = "cover_photo"
        case previewPhotos = "preview_photos"
    }
}
