//
//  CardsCollectionView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 02/11/2022.
//

import SwiftUI

struct CardsCollectionView: View {
    @State var isLoaded = false
    @StateObject var cardsProvider = CardsProvider.shared
    var columns = [
        GridItem(.adaptive(minimum: 80), spacing: 8)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(Array(cardsProvider.data.enumerated()), id: \.element.id) { index, card in
                    NavigationLink(destination: CardDetailView(card: card)) {
                        AsyncImage(url: card.imageUrl,
                                   content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }) {
                            ProgressView()
                        }
                        .onAppear() {
                            if index >= cardsProvider.data.count - 5 {
                                cardsProvider.getData()
                            }
                        }
                    }
                }
                .frame(height: 120)
            }
            .padding([.leading, .trailing], 10)
        }
        .scrollDismissesKeyboard(.immediately)
        .onAppear() {
            if !isLoaded {
                isLoaded = true
                cardsProvider.getData()
            }
        }
    }
}

struct CardsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CardsCollectionView()
    }
}
