//
//  Medium.swift
//  DDD.Attendance
//
//  Created by ParkSungJoon on 01/09/2019.
//  Copyright © 2019 DDD. All rights reserved.
//

import Foundation

// MARK: - Medium
struct Medium: Codable {
    let success: Bool
    let payload: Payload
    let v: Int
    let b: String
}

// MARK: - Payload
struct Payload: Codable {
    let user: UserClass
    let streamItems: [StreamItem]
    let userMeta: UserMeta
    let userNavItemList: UserNavItemList
    let userNavActiveIndex: Int
    let profileTypeName: String
    let isStandaloneEditPage: Bool
    let references: References
    let paging: Paging
}

// MARK: - Paging
struct Paging: Codable {
    let path: String
    let next: Next
}

// MARK: - Next
struct Next: Codable {
    let limit: Int
    let to, source: String
    let ignoredIds: [JSONAny]
    let page: Int
}

// MARK: - References
struct References: Codable {
    let user: User
    let post: [String: Post]
    let social: Social
    let socialStats: SocialStats
    
    enum CodingKeys: String, CodingKey {
        case user = "User"
        case post = "Post"
        case social = "Social"
        case socialStats = "SocialStats"
    }
}

// MARK: - Post
struct Post: Codable {
    let id, versionId: String
    let creatorId: RId
    let homeCollectionId, title: String
    let detectedLanguage: DetectedLanguage
    let latestVersion, latestPublishedVersion: String
    let hasUnpublishedEdits: Bool
    let latestRev, createdAt, updatedAt, acceptedAt: Int
    let firstPublishedAt, latestPublishedAt: Int
    let vote: Bool
    let experimentalCss, displayAuthor: String
    let content: Content
    let virtuals: Virtuals
    let coverless: Bool
    let slug, translationSourcePostId, translationSourceCreatorId: String
    let isApprovedTranslation: Bool
    let inResponseToPostId: String
    let inResponseToRemovedAt: Int
    let isTitleSynthesized, allowResponses: Bool
    let importedUrl: String
    let importedPublishedAt, visibility: Int
    let uniqueSlug: String
    let previewContent: PreviewContent
    let license: Int
    let inResponseToMediaResourceId, canonicalUrl, approvedHomeCollectionId, newsletterId: String
    let webCanonicalUrl, mediumUrl, migrationId: String
    let notifyFollowers, notifyTwitter, notifyFacebook: Bool
    let responseHiddenOnParentPostAt: Int
    let isSeries, isSubscriptionLocked: Bool
    let seriesLastAppendedAt, audioVersionDurationSec: Int
    let sequenceId: String
    let isNsfw, isEligibleForRevenue, isBlockedFromHightower: Bool
    let deletedAt, lockedPostSource, hightowerMinimumGuaranteeStartsAt, hightowerMinimumGuaranteeEndsAt: Int
    let featureLockRequestAcceptedAt, mongerRequestType, layerCake: Int
    let socialTitle, socialDek, editorialPreviewTitle, editorialPreviewDek: String
    let curationEligibleAt: Int
    let isProxyPost: Bool
    let proxyPostFaviconUrl, proxyPostProviderName: String
    let proxyPostType: Int
    let isSuspended, isLimitedState: Bool
    let type: PostType
}

// MARK: - Content
struct Content: Codable {
    let subtitle: String
    let postDisplay: PostDisplay
}

// MARK: - PostDisplay
struct PostDisplay: Codable {
    let coverless: Bool
}

enum RId: String, Codable {
    case the19832Fdbf9B5 = "19832fdbf9b5"
}

enum DetectedLanguage: String, Codable {
    case ko = "ko"
}

// MARK: - PreviewContent
struct PreviewContent: Codable {
    let bodyModel: BodyModel
    let isFullContent: Bool
    let subtitle: String
}

// MARK: - BodyModel
struct BodyModel: Codable {
    let paragraphs: [Paragraph]
    let sections: [Section]
}

// MARK: - Paragraph
struct Paragraph: Codable {
    let name: String
    let type: Int
    let text: String
    let layout: Int?
    let metadata: CoverImageClass?
    let markups: [Markup]?
    let alignment: Int?
}

// MARK: - Markup
struct Markup: Codable {
    let type, start, end: Int
    let href, title, rel, name: String
    let anchorType: Int
    let creatorIds: [JSONAny]
    let userId: String
}

// MARK: - CoverImageClass
struct CoverImageClass: Codable {
    let id: String
    let originalWidth, originalHeight: Int?
    let isFeatured: Bool?
}

// MARK: - Section
struct Section: Codable {
    let startIndex: Int
}

enum PostType: String, Codable {
    case post = "Post"
}

// MARK: - Virtuals
struct Virtuals: Codable {
    let allowNotes: Bool
    let previewImage: PreviewImage
    let wordCount, imageCount: Int
    let readingTime: Double
    let subtitle: String
    let usersBySocialRecommends: [JSONAny]
    let noIndex: Bool
    let recommends: Int
    let isBookmarked: Bool
    let tags: [Tag]
    let socialRecommendsCount, responsesCreatedCount: Int
    let links: Links
    let isLockedPreviewOnly: Bool
    let metaDescription: String
    let totalClapCount, sectionCount, readingList: Int
    let topics: [JSONAny]
}

// MARK: - Links
struct Links: Codable {
    let entries: [Entry]
    let version: String
    let generatedAt: Int
}

// MARK: - Entry
struct Entry: Codable {
    let url: String
    let alts: [Alt]
    let httpStatus: Int
}

// MARK: - Alt
struct Alt: Codable {
    let type: Int
    let url: String
}

// MARK: - PreviewImage
struct PreviewImage: Codable {
    let imageId, filter, backgroundSize: String
    let originalWidth, originalHeight: Int
    let strategy: Strategy
    let height, width: Int
}

enum Strategy: String, Codable {
    case resample = "resample"
}

// MARK: - Tag
struct Tag: Codable {
    let slug, name: String
    let postCount: Int
    let metadata: TagMetadata
    let type: TagType
}

// MARK: - TagMetadata
struct TagMetadata: Codable {
    let postCount: Int
    let coverImage: CoverImageClass
}

enum TagType: String, Codable {
    case tag = "Tag"
}

// MARK: - Social
struct Social: Codable {
    let the19832Fdbf9B5: Social19832Fdbf9B5
    
    enum CodingKeys: String, CodingKey {
        case the19832Fdbf9B5 = "19832fdbf9b5"
    }
}

// MARK: - Social19832Fdbf9B5
struct Social19832Fdbf9B5: Codable {
    let userId: String
    let targetUserId: RId
    let type: String
}

// MARK: - SocialStats
struct SocialStats: Codable {
    let the19832Fdbf9B5: SocialStats19832Fdbf9B5
    
    enum CodingKeys: String, CodingKey {
        case the19832Fdbf9B5 = "19832fdbf9b5"
    }
}

// MARK: - SocialStats19832Fdbf9B5
struct SocialStats19832Fdbf9B5: Codable {
    let userId: RId
    let usersFollowedCount, usersFollowedByCount: Int
    let type: String
}

// MARK: - User
struct User: Codable {
    let the19832Fdbf9B5: UserClass
    
    enum CodingKeys: String, CodingKey {
        case the19832Fdbf9B5 = "19832fdbf9b5"
    }
}

// MARK: - UserClass
struct UserClass: Codable {
    let userId: RId
    let name, username: String
    let createdAt: Int
    let imageId, backgroundImageId, bio: String
    let allowNotes, mediumMemberAt: Int
    let isNsfw, isWriterProgramEnrolled, isQuarantined, isSuspended: Bool
    let type: String
}

// MARK: - StreamItem
struct StreamItem: Codable {
    let createdAt: Int
    let heading: StreamItemHeading?
    let randomId: String
    let itemType: ItemType
    let type: StreamItemType
    let postPreview: PostPreview?
}

// MARK: - StreamItemHeading
struct StreamItemHeading: Codable {
    let text: String
    let heading: HeadingHeading
}

// MARK: - HeadingHeading
struct HeadingHeading: Codable {
    let fallbackTitle: String
    let headingBasic: HeadingBasic
    let headingType: String
}

// MARK: - HeadingBasic
struct HeadingBasic: Codable {
    let title: String
}

enum ItemType: String, Codable {
    case heading = "heading"
    case postPreview = "postPreview"
}

// MARK: - PostPreview
struct PostPreview: Codable {
    let postId: String
    let postSuggestionReasons: [PostSuggestionReason]
}

// MARK: - PostSuggestionReason
struct PostSuggestionReason: Codable {
    let reason: Int
}

enum StreamItemType: String, Codable {
    case streamItem = "StreamItem"
}

// MARK: - UserMeta
struct UserMeta: Codable {
    let numberOfPostsPublished: Int
    let userId: RId
    let userSuggestionReason: UserSuggestionReason
    let collectionIds: [JSONAny]
    let authorTags: [AuthorTag]
    let featuredPostId: String
    let topWriterInTags: [JSONAny]
    let type: String
}

// MARK: - AuthorTag
struct AuthorTag: Codable {
    let slug, name: String
    let postCount: Int
    let metadata: AuthorTagMetadata
    let type: TagType
}

// MARK: - AuthorTagMetadata
struct AuthorTagMetadata: Codable {
    let postCount: Int
    let coverImage: CoverImage
}

// MARK: - CoverImage
struct CoverImage: Codable {
    let id: String
    let originalWidth, originalHeight: Int?
    let isFeatured: Bool?
    let unsplashPhotoId, backgroundSize, filter, externalSrc: String?
    let focusPercentX, focusPercentY: Int?
    let alt: String?
    let repairedAt: Int?
}

// MARK: - UserSuggestionReason
struct UserSuggestionReason: Codable {
    let followeesWhoFollow: FolloweesWhoFollow
    let reason: String
}

// MARK: - FolloweesWhoFollow
struct FolloweesWhoFollow: Codable {
    let users: [JSONAny]
}

// MARK: - UserNavItemList
struct UserNavItemList: Codable {
    let userNavItems: [UserNavItem]
}

// MARK: - UserNavItem
struct UserNavItem: Codable {
    let title: String
    let url: String
    let systemItem: SystemItem
    let navType: String
}

// MARK: - SystemItem
struct SystemItem: Codable {
    let systemType: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
