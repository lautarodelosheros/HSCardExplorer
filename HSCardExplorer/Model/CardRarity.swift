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
    
    var imageName: String {
        switch id {
        case 1:
            return "CommonRarityGem"
        case 2:
            return ""
        case 3:
            return "RareRarityGem"
        case 4:
            return "EpicRarityGem"
        case 5:
            return "LegendaryRarityGem"
        default:
            return ""
        }
    }
    
    static var remoteCardRarities: [CardRarity]?
}
