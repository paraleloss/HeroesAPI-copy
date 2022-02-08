//
//  LibroData.swift
//  HeroesAPI
//
//  Created by Saúl Pérez on 08/02/22.
//

import Foundation

// MARK: - LibroData
struct LibroData: Decodable {
    //let kind: String
    //let totalItems: Int
    let items: [Item]
}


// MARK: - Item
struct Item: Codable {
    let volumeInfo: VolumeInfo
    let searchInfo: SearchInfo?
}


// MARK: - SearchInfo
struct SearchInfo: Codable {
    let textSnippet: String
}

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String
    //et authors: [String]
    let publishedDate: String
   // let categories: [String]?
    let imageLinks: ImageLinks?
    let description: String?
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
}
