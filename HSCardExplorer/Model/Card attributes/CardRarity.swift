//
//  CardRarity.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 04/11/2022.
//

import Foundation

struct CardRarity: CardAttribute {
    
    let id: Int
    let name: String
    let slug: String
    
    var imageName: String? {
        switch id {
        case 1:
            return "CommonRarityGem"
        case 2:
            return nil
        case 3:
            return "RareRarityGem"
        case 4:
            return "EpicRarityGem"
        case 5:
            return "LegendaryRarityGem"
        default:
            return nil
        }
    }
    
    static var cardRarities: [CardRarity]?
}
