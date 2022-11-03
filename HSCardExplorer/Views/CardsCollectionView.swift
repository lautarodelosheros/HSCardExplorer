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
        GridItem(.adaptive(minimum: 60), spacing: 8)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(cardsProvider.cards) { card in
                    AsyncImage(url: card.imageUrl,
                               content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }) {
                        ProgressView()
                    }
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
