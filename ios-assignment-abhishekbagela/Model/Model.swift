//
//  Model.swift
//  ios-assignment-abhishekbagela
//
//  Created by Abhishek Bagela on 16/04/24.
//

import Foundation

class Model: Codable {
    var id: String?
    var title: String?
    var language: String?
    var thumbnail: Thumbnail?
    var mediaType: Int?
    var coverageURL: String?
    var publishedAt: String?
    var publishedBy: String?
    var backupDetails: BackupDetails?
    
    init(id: String? = nil, title: String? = nil, language: String? = nil, thumbnail: Thumbnail? = nil, mediaType: Int? = nil, coverageURL: String? = nil, publishedAt: String? = nil, publishedBy: String? = nil, backupDetails: BackupDetails? = nil) {
        self.id = id
        self.title = title
        self.language = language
        self.thumbnail = thumbnail
        self.mediaType = mediaType
        self.coverageURL = coverageURL
        self.publishedAt = publishedAt
        self.publishedBy = publishedBy
        self.backupDetails = backupDetails
    }
}

class Thumbnail: Codable {
    var id: String?
    var version: Int?
    var domain: String?
    var basePath: String?
    var key: String?
    var qualities: [Int]?
    var aspectRatio: Int?
    
    init(id: String? = nil, version: Int? = nil, domain: String? = nil, basePath: String? = nil, key: String? = nil, qualities: [Int]? = nil, aspectRatio: Int? = nil) {
        self.id = id
        self.version = version
        self.domain = domain
        self.basePath = basePath
        self.key = key
        self.qualities = qualities
        self.aspectRatio = aspectRatio
    }
}

class BackupDetails: Codable {
    var pdfLink: String?
    var screenshotURL: String?
    
    init(pdfLink: String? = nil, screenshotURL: String? = nil) {
        self.pdfLink = pdfLink
        self.screenshotURL = screenshotURL
    }
}
