//
//  CardsFilterView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import SwiftUI

struct CardsFilterView: View {
    @State private var didPerformChanges = false
    @State private var cardSet = CardsProvider.shared.cardSet
    @State private var manaCost = CardsProvider.shared.manaCost
    @State private var attack = CardsProvider.shared.attack
    @State private var health = CardsProvider.shared.health
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
                Stepper(
                    "Mana cost: \(manaCost == -1 ? "Any" : String(manaCost))",
                    value: $manaCost,
                    in: -1...50
                )
                Stepper(
                    "Attack: \(attack == -1 ? "Any" : String(attack))",
                    value: $attack,
                    in: -1...50
                )
                Stepper(
                    "Health: \(health == -1 ? "Any" : String(health))",
                    value: $health,
                    in: -1...50
                )
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
            didPerformChanges = true
            CardsProvider.shared.cardSet = newValue
        }
        .onChange(of: manaCost) { newValue in
            didPerformChanges = true
            CardsProvider.shared.manaCost = newValue
        }
        .onChange(of: attack) { newValue in
            didPerformChanges = true
            CardsProvider.shared.attack = newValue
        }
        .onChange(of: health) { newValue in
            didPerformChanges = true
            CardsProvider.shared.health = newValue
        }
        .onChange(of: shouldShowUncollectibleCards) { newValue in
            didPerformChanges = true
            CardsProvider.shared.shouldShowUncollectibleCards = newValue
        }
        .onChange(of: sortOption) { newValue in
            didPerformChanges = true
            CardsProvider.shared.sortOption = newValue
        }
        .onChange(of: sortDirection) { newValue in
            didPerformChanges = true
            CardsProvider.shared.sortDirection = newValue
        }
        .onDisappear() {
            guard didPerformChanges else { return }
            CardsProvider.shared.resetData()
            CardsProvider.shared.getData()
        }
    }
}

struct CardsFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CardsFilterView()
    }
}
