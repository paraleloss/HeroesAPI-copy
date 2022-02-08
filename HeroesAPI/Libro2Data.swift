//
//  Libro2Data.swift
//  HeroesAPI
//
//  Created by Saúl Pérez on 08/02/22.
//

import Foundation

struct Libro2Data: Decodable{
        let numFound, start: Int
        let numFoundExact: Bool
        let docs: [Doc]
    }

    // MARK: - Doc
    struct Doc: Codable {
        let key, type, name: String
        let alternateNames: [String]?
        let birthDate, deathDate, topWork: String?
        let workCount: Int
        let topSubjects: [String]?
        let version: Double

        enum CodingKeys: String, CodingKey {
            case key, type, name
            case alternateNames = "alternate_names"
            case birthDate = "birth_date"
            case deathDate = "death_date"
            case topWork = "top_work"
            case workCount = "work_count"
            case topSubjects = "top_subjects"
            case version = "_version_"
        }
}
