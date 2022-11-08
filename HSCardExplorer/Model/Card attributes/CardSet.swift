//
//  CardSet.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import Foundation

struct CardSet: CardAttribute {
    
    let id: Int
    let name: String
    let slug: String
    let imageName: String?
    
    static var sets: [CardSet]?
}
