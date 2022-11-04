//
//  MainView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 01/11/2022.
//

import SwiftUI
import Combine

struct MainView: View {
    @State private var isShowingFilter = false
    @State private var searchText = ""
    @Environment(\.isSearching) private var isSearching
    
    @State private var timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State private var timer: Cancellable?
    @State private var secondsElapsed = 0
    
    private func cancelTimer() {
        timer?.cancel()
        secondsElapsed = 0
    }
    
    private func refreshSearch() {
        CardsProvider.shared.searchText = searchText
        CardsProvider.shared.resetData()
        CardsProvider.shared.getData()
    }
    
    var body: some View {
        NavigationView {
            CardsCollectionView()
                .keyboardToolbar(height: 44) {
                    ZStack(alignment: .trailing) {
                        Color.clear
                        Button {
                            isShowingFilter.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .imageScale(.large)
                        }
                        .padding(.trailing, 10)
                    }
                    .background(.ultraThinMaterial)
                }
                .navigationTitle("Card Explorer")
                .searchable(text: $searchText, placement: .automatic, prompt: "Search cards")
                .onChange(of: searchText) { newValue in
                    cancelTimer()
                    if !searchText.isEmpty {
                        self.timerPublisher = Timer.publish(every: 1, on: .main, in: .common)
                        self.timer = timerPublisher.connect()
                    } else {
                        refreshSearch()
                    }
                }
                .onReceive(timerPublisher) { time in
                    self.secondsElapsed += 1
                    if self.secondsElapsed >= 2 {
                        cancelTimer()
                        refreshSearch()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowingFilter.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                    }
                }
        }
        .sheet(isPresented: $isShowingFilter) {
            CardsFilterView(isPresented: $isShowingFilter)
                .presentationDetents([.medium, .large])
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
