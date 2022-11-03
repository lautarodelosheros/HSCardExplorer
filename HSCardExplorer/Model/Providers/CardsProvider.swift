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
    
    /// Don't call directly. Always call getData
    override func fetchData() {
        super.fetchData()
        HearthstoneAPIClient.shared.getCards(page: currentPage, pageSize: pageSize)?.sink { completion in
            self.isFetchingFromServer = false
            switch completion {
            case .finished:
                self.currentPage += 1
            case .failure(let error):
                debugPrint(error)
            }
        } receiveValue: { response in
            self.addData(response.cards)
            if response.cards.count != self.pageSize {
                self.noMoreData = true
            }
        }
        .store(in: &subscriptions)
    }
}
