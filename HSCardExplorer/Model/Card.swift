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
