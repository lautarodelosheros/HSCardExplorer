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
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                NavigationLink(destination: CardDetailView()) {
                    Text("Hello, world!")
                }
            }
            .navigationTitle("Card Explorer")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
