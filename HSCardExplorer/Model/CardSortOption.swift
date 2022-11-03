//
//  CardSortOption.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import Foundation

struct CardSortOption: Identifiable, Hashable {
    
    let id: String
    let title: String
    
    private init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    static let manaCost = CardSortOption(id: "manaCost", title: "Mana cost")
    static let attack = CardSortOption(id: "attack", title: "Attack")
    static let health = CardSortOption(id: "health", title: "Health")
    static let name = CardSortOption(id: "name", title: "Name")
    static let dataAdded = CardSortOption(id: "dataAdded", title: "Date added")
    static let `class` = CardSortOption(id: "class", title: "Class")
    static let groupByClass = CardSortOption(id: "groupByClass", title: "Group by class")
}
