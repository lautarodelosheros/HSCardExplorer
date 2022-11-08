//
//  HeroClass.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 04/11/2022.
//

import Foundation

struct HeroClass: CardAttribute {
    
    let id: Int
    let name: String
    let slug: String
    let imageName: String?
    
    static var heroClasses: [HeroClass]?
}
