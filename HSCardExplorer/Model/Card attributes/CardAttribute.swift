//
//  CardAttribute.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 08/11/2022.
//

import Foundation

protocol CardAttribute: Codable, Identifiable, Hashable {
    
    var id: Int { get }
    var name: String { get }
    var slug: String { get }
    var imageName: String? { get }
}
