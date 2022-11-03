//
//  CardsFilterView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import SwiftUI

struct CardsFilterView: View {
    @State private var cardSet = CardsProvider.shared.cardSet
    @State private var shouldShowUncollectibleCards = CardsProvider.shared.shouldShowUncollectibleCards
    @State private var sortOption = CardsProvider.shared.sortOption
    @State private var sortDirection = CardsProvider.shared.sortDirection
    
    private let sortOptions: [CardSortOption] = [
        .name,
        .class,
        .attack,
        .health,
        .manaCost,
        .dataAdded,
        .groupByClass
    ]
    
    private let sortDirections: [CardSortDirection] = [
        .ascendant,
        .descendant
    ]
    
    var body: some View {
        Form {
            Section {
                Picker("Card set", selection: $cardSet) {
                    Text("All")
                        .tag(nil as CardSet?)
                    ForEach(CardSet.availableSets) { cardSet in
                        Text(cardSet.name)
                            .tag(cardSet as CardSet?)
                    }
                }
            }
            Section {
                Toggle("Show uncollectible cards", isOn: $shouldShowUncollectibleCards)
            }
            Section {
                Picker("Sort cards by", selection: $sortOption) {
                    ForEach(sortOptions) { sortOption in
                        Text(sortOption.title)
                            .tag(sortOption)
                    }
                }
                Picker("Sort direction", selection: $sortDirection) {
                    ForEach(sortDirections) { sortDirection in
                        Text(sortDirection.title)
                            .tag(sortDirection)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .onChange(of: cardSet) { newValue in
            CardsProvider.shared.cardSet = newValue
        }
        .onChange(of: shouldShowUncollectibleCards) { newValue in
            CardsProvider.shared.shouldShowUncollectibleCards = newValue
        }
        .onChange(of: sortOption) { newValue in
            CardsProvider.shared.sortOption = newValue
        }
        .onChange(of: sortDirection) { newValue in
            CardsProvider.shared.sortDirection = newValue
        }
    }
}

struct CardsFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CardsFilterView()
    }
}
