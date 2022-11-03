//
//  CardSortDirection.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import Foundation

struct CardSortDirection: Identifiable, Hashable {
    
    let id: String
    let title: String
    
    private init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    static let ascendant = CardSortDirection(id: "asc", title: "Ascendant")
    static let descendant = CardSortDirection(id: "desc", title: "Descendant")
}
