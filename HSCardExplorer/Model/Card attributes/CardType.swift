//
//  CardType.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 08/11/2022.
//

import Foundation

struct CardType: CardAttribute {
    
    let id: Int
    let name: String
    let slug: String
    let imageName: String?
    
    static var cardTypes: [CardType]?
}
