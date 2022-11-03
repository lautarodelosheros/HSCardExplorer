//
//  CardSet.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import Foundation

struct CardSet: Codable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    let slug: String
    
    static var availableSets: [CardSet] {
        guard let remoteSets = remoteSets else {
            return []
        }
        return remoteSets
    }
    
    static var remoteSets: [CardSet]?
}
