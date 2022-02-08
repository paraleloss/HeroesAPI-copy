//
//  HeroStats.swift
//  HeroesAPI
//
//  Created by Saúl Pérez on 07/02/22.
//

import Foundation

struct HeroStats: Decodable{
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
}

