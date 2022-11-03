//
//  MainView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 01/11/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            CardsCollectionView()
            .navigationTitle("Card Explorer")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {

                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
