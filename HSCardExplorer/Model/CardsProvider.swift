//
//  CardsProvider.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 02/11/2022.
//

import Foundation
import Combine

class CardsProvider: ObservableObject {
    
    static let shared = CardsProvider()
    private init() {}
    
    @Published var cards = [Card]()
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchCards() {
        if cards.isEmpty {
            HearthstoneAPIClient.shared.getCards()?.sink { completion in
                switch completion {
                case .finished:
                    debugPrint("Success")
                case .failure(let error):
                    debugPrint(error)
                }
            } receiveValue: { response in
                self.cards = response.cards
            }
            .store(in: &subscriptions)
        }
    }
}
