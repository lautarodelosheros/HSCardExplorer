//
//  CardAttributePicker.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 08/11/2022.
//

import SwiftUI

struct CardAttributePicker<T: CardAttribute>: View {
    @State var attribute: T?
    
    let title: String
    let options: [T]
    let onChange: (T?) -> Void
    
    var body: some View {
        Picker(title, selection: $attribute) {
            Text("All")
                .tag(nil as T?)
            ForEach(options) { option in
                HStack {
                    if let imageName = option.imageName {
                        Image(imageName)
                    }
                    Text(option.name)
                }
                .tag(option as T?)
            }
        }
        .onChange(of: attribute, perform: onChange)
    }
}

struct CardAttributePicker_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            CardAttributePicker<CardRarity>(
                attribute: CardsProvider.shared.cardRarity,
                title: "Rarity",
                options: [CardRarity(id: 0, name: "Common", slug: "common")],
                onChange: { cardRarity in
                    CardsProvider.shared.cardRarity = cardRarity
                }
            )
        }
            .preferredColorScheme(.dark)
    }
}
