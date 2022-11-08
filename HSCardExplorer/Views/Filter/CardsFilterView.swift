//
//  CardsFilterView.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import SwiftUI

struct CardsFilterView: View {
    @Binding var isPresented: Bool
    @State private var didPerformChanges = false
    @State private var manaCost = CardsProvider.shared.manaCost
    @State private var attack = CardsProvider.shared.attack
    @State private var health = CardsProvider.shared.health
    @State private var shouldShowUncollectibleCards = CardsProvider.shared.shouldShowUncollectibleCards
    @State private var sortOption = CardsProvider.shared.sortOption
    @State private var sortDirection = CardsProvider.shared.sortDirection
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    CardAttributePicker(
                        attribute: CardsProvider.shared.cardSet,
                        title: "Card set",
                        options: CardSet.sets ?? []
                    ) { newValue in
                        didPerformChanges = true
                        CardsProvider.shared.cardSet = newValue
                    }
                    CardAttributePicker(
                        attribute: CardsProvider.shared.heroClass,
                        title: "Class",
                        options: HeroClass.heroClasses ?? []
                    ) { newValue in
                        didPerformChanges = true
                        CardsProvider.shared.heroClass = newValue
                    }
                    CardAttributePicker(
                        attribute: CardsProvider.shared.cardRarity,
                        title: "Rarity",
                        options: CardRarity.cardRarities ?? []
                    ) { newValue in
                        didPerformChanges = true
                        CardsProvider.shared.cardRarity = newValue
                    }
                    CardAttributePicker(
                        attribute: CardsProvider.shared.cardType,
                        title: "Card type",
                        options: CardType.cardTypes ?? []
                    ) { newValue in
                        didPerformChanges = true
                        CardsProvider.shared.cardType = newValue
                    }
                    CardAttributePicker(
                        attribute: CardsProvider.shared.minionType,
                        title: "Minion type",
                        options: MinionType.minionTypes ?? []
                    ) { newValue in
                        didPerformChanges = true
                        CardsProvider.shared.minionType = newValue
                    }
                }
                Section {
                    Stepper(
                        "Mana cost: \t **\(manaCost == -1 ? "Any" : String(manaCost))**",
                        value: $manaCost,
                        in: -1...50
                    )
                    Stepper(
                        "Attack: \t\t **\(attack == -1 ? "Any" : String(attack))**",
                        value: $attack,
                        in: -1...50
                    )
                    Stepper(
                        "Health: \t\t **\(health == -1 ? "Any" : String(health))**",
                        value: $health,
                        in: -1...50
                    )
                }
                Section {
                    Toggle("Show uncollectible cards", isOn: $shouldShowUncollectibleCards)
                }
                Section {
                    Picker("Sort cards by", selection: $sortOption) {
                        ForEach(CardSortOption.allCases) { sortOption in
                            Text(sortOption.title)
                                .tag(sortOption)
                        }
                    }
                    Picker("Sort direction", selection: $sortDirection) {
                        ForEach(CardSortDirection.allCases) { sortDirection in
                            Text(sortDirection.title)
                                .tag(sortDirection)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
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
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        isPresented.toggle()
                    }
                }
            }
            .padding(.top, -32)
        }
    }
}

struct CardsFilterView_Previews: PreviewProvider {
    @State static var isPresented = true
    static var previews: some View {
        CardsFilterView(isPresented: $isPresented)
            .preferredColorScheme(.dark)
    }
}
