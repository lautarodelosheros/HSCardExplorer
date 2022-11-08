//
//  MinionType.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 08/11/2022.
//

import Foundation

struct MinionType: CardAttribute {
    
    let id: Int
    let name: String
    let slug: String
    let imageName: String?
    
    static var minionTypes: [MinionType]?
}
