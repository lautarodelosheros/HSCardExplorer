//
//  HeroClass.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 04/11/2022.
//

import Foundation

struct HeroClass: Codable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    let slug: String
    
    static var availableHeroClasses: [HeroClass] {
        guard let remoteHeroClasses = remoteHeroClasses else {
            return []
        }
        return remoteHeroClasses
    }
    
    static var remoteHeroClasses: [HeroClass]?
}
