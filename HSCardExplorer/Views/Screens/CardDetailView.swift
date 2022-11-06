//
//  CardDetailView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 02/11/2022.
//

import SwiftUI

struct CardDetailView: View {
    @State var card: Card
    
    @ObservedObject var motionManager = MotionManager()
    
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
                .frame(height: 440)
                .padding(.leading, 16)
                .modifier(RotationMotionModifier(manager: motionManager, multiplier: 20))
            }
        }
        .padding(.top, 4)
        .navigationTitle(card.name)
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(card: Card.exampleCard)
    }
}
