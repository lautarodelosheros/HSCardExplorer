//
//  MainView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 01/11/2022.
//

import SwiftUI

struct MainView: View {
    @State private var isShowingFilter = false
    
    var body: some View {
        NavigationView {
            CardsCollectionView()
            .navigationTitle("Card Explorer")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingFilter.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    .sheet(isPresented: $isShowingFilter) {
                        CardsFilterView()
                            .presentationDetents([.medium, .large])
                    }
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
