//
//  CardsProvider.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 02/11/2022.
//

import Foundation
import Combine

class CardsProvider: DataProvider<Card> {
    
    static let shared = CardsProvider()
    private init() {
        super.init(pageSize: 40)
    }
    
    var searchText = ""
    var cardSet: CardSet?
    var manaCost: Int = -1
    var attack: Int = -1
    var health: Int = -1
    var heroClass: HeroClass?
    var cardRarity: CardRarity?
    var shouldShowUncollectibleCards = false
    var sortOption = CardSortOption.name
    var sortDirection = CardSortDirection.ascendant
    
    private var retryCount = 0
    private let retryLimit = 6
    
    /// Don't call directly. Always call getData
    override func fetchData() {
        super.fetchData()
        let manaCost = manaCost == -1 ? nil : manaCost
        let attack = attack == -1 ? nil : attack
        let health = health == -1 ? nil : health
        HearthstoneAPIClient.shared.getCards(
            searchText: searchText,
            cardSet: cardSet,
            manaCost: manaCost,
            attack: attack,
            health: health,
            heroClass: heroClass,
            cardRarity: cardRarity,
            shouldShowUncollectibleCards: shouldShowUncollectibleCards,
            sortOption: sortOption,
            sortDirection: sortDirection,
            page: currentPage,
            pageSize: pageSize
        )
        .sink { completion in
            switch completion {
            case .finished:
                self.currentPage += 1
                self.retryCount = 0
            case .failure(let error):
                // Retry
                if self.retryCount < self.retryLimit {
                    self.retryCount += 1
                    self.fetchData()
                }
                debugPrint(error)
            }
            self.isFetchingFromServer = false
        } receiveValue: { response in
            self.addData(response.cards)
            if response.cards.count != self.pageSize {
                self.noMoreData = true
            }
        }
        .store(in: &subscriptions)
    }
}
