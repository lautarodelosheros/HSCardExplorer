//
//  MetadataResponse.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import Foundation

struct MetadataResponse: Codable {
    
    let sets: [CardSet]
    let classes: [HeroClass]
    let rarities: [CardRarity]
}
