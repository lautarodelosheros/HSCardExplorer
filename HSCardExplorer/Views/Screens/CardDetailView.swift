//
//  CardDetailView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 02/11/2022.
//

import SwiftUI

struct CardDetailView: View {
    @State var card: Card
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: card.imageUrl,
                           content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }) {
                    ProgressView()
                }
                Text(card.name)
                    .font(.title)
            }
        }
        .padding(.top, 0.3)
        .navigationTitle(card.name)
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: Card.exampleCard)
    }
}
