import Foundation

struct Urls: Codable, Hashable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

struct Links: Codable, Hashable {
    let selfLink: String
    let html: String

    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html
    }
}

struct Social: Codable, Hashable {
    let instagramUsername: String?
    let portfolioUrl: String?
    let twitterUsername: String?
    let paypalEmail: String?
    
    var connectable: Bool {
        portfolioUrl != nil || instagramUsername != nil || twitterUsername != nil || paypalEmail != nil
    }

    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case portfolioUrl = "portfolio_url"
        case twitterUsername = "twitter_username"
        case paypalEmail = "paypal_email"
    }
}

struct ProfileImage: Codable, Hashable {
    let small: String
    let medium: String
    let large: String
}

struct Sponsorship: Codable, Hashable {
    let impressionUrls: [String] = []
    let tagline: String
    let taglineUrl: String
    let sponsor: User
    
    enum CodingKeys: String, CodingKey {
        case impressionUrls = "impression_urls"
        case tagline = "tagline"
        case taglineUrl = "tagline_url"
        case sponsor = "sponsor"
    }
}

struct Submition: Codable, Hashable {
    let status: String
}

struct Breadcrumb: Codable, Hashable {
    let slug: String
    let title: String
    let index: Int
    let type: String
}

struct Tag: Codable, Hashable, Identifiable {
    let id = UUID().uuidString
    let type: String
    let title: String
    
    enum CodingKeys: CodingKey {
        case type
        case title
    }
}

struct Exif: Codable, Hashable {
    let make: String?
    let model: String?
    let name: String?
    let exposureTime: String?
    let aperture: String?
    let focalLength: String?
    let iso: Int?
    
    enum CodingKeys: String, CodingKey {
        case make = "make"
        case model = "model"
        case name = "name"
        case exposureTime = "exposure_time"
        case aperture = "aperture"
        case focalLength = "focal_length"
        case iso = "iso"
    }
}

struct Position: Codable, Hashable {
    let latitude: Float?
    let longitude: Float?
}

struct Location: Codable, Hashable {
    let name: String?
    let city: String?
    let country: String?
    let position: Position?
}

struct Meta: Codable, Hashable {
    let index: Bool
}

struct RelatedCollections: Codable, Hashable {
    let total: Int
    let type: String
    let results: [Collection]
}

struct Tags: Codable, Hashable {
    let custom: [Tag]
    let aggregated: [Tag]
}

struct Badge: Codable, Hashable {
    let title: String
    let primary: Bool
    let slug: String
    let link: String?
}
