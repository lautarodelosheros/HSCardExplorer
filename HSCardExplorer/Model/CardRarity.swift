//
//  CardRarity.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 04/11/2022.
//

import Foundation

struct CardRarity: Codable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    let slug: String
    
    static var availableCardRarities: [CardRarity] {
        guard let remoteCardRarities = remoteCardRarities else {
            return []
        }
        return remoteCardRarities
    }
    
    static var remoteCardRarities: [CardRarity]?
}
