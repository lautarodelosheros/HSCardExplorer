//
//  CardsCollectionView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 02/11/2022.
//

import SwiftUI

struct CardsCollectionView: View {
    var columns = [
        GridItem(.adaptive(minimum: 100), spacing: 8)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(0...100, id: \.self) { _ in
                    Color.orange
                }
                .frame(height: 100)
            })
        }
    }
}

struct CardsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CardsCollectionView()
    }
}
