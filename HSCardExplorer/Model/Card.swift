//
//  Card.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 02/11/2022.
//

import Foundation

struct Card: Codable, Identifiable {
    
    let id: Int
    let name: String
    let image: String
    
    var imageUrl: URL? {
        URL(string: image)
    }
}

extension Card {
    
    static let exampleCard = Card(
        id: 0,
        name: "Abominable Bowman",
        image: "https://d15f34w2p8l1cc.cloudfront.net/hearthstone/dd2a917a839ddf9c4c32efa490dd8f1fc3830722514629a5aae77d27f114e27c.png"
    )
}
