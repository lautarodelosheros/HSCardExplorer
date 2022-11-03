//
//  CardsCollectionView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 02/11/2022.
//

import SwiftUI

struct CardsCollectionView: View {
    @StateObject var cardsProvider = CardsProvider.shared
    var columns = [
        GridItem(.adaptive(minimum: 100), spacing: 8)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(cardsProvider.cards) { card in
                    Text(card.name)
                }
                .frame(height: 100)
            })
        }
        .onAppear() {
            cardsProvider.fetchCards()
        }
    }
}

struct CardsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CardsCollectionView()
    }
}
