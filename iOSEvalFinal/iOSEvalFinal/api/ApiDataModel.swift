//
//  ApiDataModel.swift
//  iOSEvalFinal
//
//  Created by Duc Luu on 25/10/2023.
//

import Foundation

// MARK: - GameResponse
struct GameResponse: Codable {
    let featuredWin, featuredMAC, featuredLinux: [Featured]
    let layout: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case featuredWin = "featured_win"
        case featuredMAC = "featured_mac"
        case featuredLinux = "featured_linux"
        case layout, status
    }
}

// MARK: - Featured
struct Featured: Codable {
    let id, type: Int
    let name: String
    let discounted: Bool
    let discountPercent: Int
    let originalPrice: Int?
    let finalPrice: Int?
    let currency: Currency
    let largeCapsuleImage, smallCapsuleImage: String
    let windowsAvailable, macAvailable, linuxAvailable, streamingvideoAvailable: Bool
    let discountExpiration: Int?
    let headerImage: String
    let controllerSupport: String?

    enum CodingKeys: String, CodingKey {
        case id, type, name, discounted
        case discountPercent = "discount_percent"
        case originalPrice = "original_price"
        case finalPrice = "final_price"
        case currency
        case largeCapsuleImage = "large_capsule_image"
        case smallCapsuleImage = "small_capsule_image"
        case windowsAvailable = "windows_available"
        case macAvailable = "mac_available"
        case linuxAvailable = "linux_available"
        case streamingvideoAvailable = "streamingvideo_available"
        case discountExpiration = "discount_expiration"
        case headerImage = "header_image"
        case controllerSupport = "controller_support"
    }
}

enum Currency: String, Codable {
    case eur = "EUR"
}
