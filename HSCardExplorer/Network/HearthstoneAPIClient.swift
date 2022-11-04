//
//  HearthstoneAPIClient.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 02/11/2022.
//

import Foundation
import Combine

class HearthstoneAPIClient {
    
    static let shared = HearthstoneAPIClient()
    
    private let baseUrl = URL(string: "https://us.api.blizzard.com")!
    private var session: URLSession
    private let queue = DispatchQueue(label: "HearthstoneAPIClientQueue")
    private var subscriptions = Set<AnyCancellable>()
    
    private var accessToken = HearthstoneAPIKey.accessToken
    
    private var retryCount = 0
    private let retryLimit = 6
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        session = URLSession(configuration: configuration)
    }
    
    func initializeSession(callback: @escaping (Bool) -> Void) {
        getToken { error in
            guard !error else {
                callback(error)
                return
            }
            self.getMetadata { error in
                guard !error else {
                    callback(error)
                    return
                }
                callback(false)
            }
        }
    }
    
    func getToken(callback: @escaping (Bool) -> Void) {
        let url = URL(string: "https://oauth.battle.net/token")!
            .appending(queryItems: [URLQueryItem(name: "grant_type", value: "client_credentials")])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(Data(HearthstoneAPIKey.secret.utf8).base64EncodedString())", forHTTPHeaderField: "Authorization")
        session.dataTaskPublisher(for: request)
            .subscribe(on: queue)
            .map({
                debugPrint(String(data: $0.data, encoding: .utf8) ?? "")
                return $0.data
            })
            .decode(type: AccessTokenResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    debugPrint("Success: token")
                case .failure(let error):
                    debugPrint(error)
                    callback(true)
                }
            } receiveValue: { response in
                self.accessToken = response.accessToken
                callback(false)
            }
            .store(in: &subscriptions)
    }
    
    func getMetadata(callback: @escaping (Bool) -> Void) {
        var url = baseUrl.appending(path: "/hearthstone/metadata")
        url.append(queryItems: [
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "locale", value: "en_US")
        ])
        return session.dataTaskPublisher(for: url)
            .subscribe(on: queue)
            .map({
                debugPrint(String(data: $0.data, encoding: .utf8) ?? "")
                return $0.data
            })
            .decode(type: MetadataResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    debugPrint("Success: metadata")
                    self.retryCount = 0
                case .failure(let error):
                    debugPrint(error)
                    // Retry
                    if self.retryCount < self.retryLimit {
                        self.retryCount += 1
                        self.getMetadata(callback: callback)
                    } else {
                        self.retryCount = 0
                        callback(true)
                    }
                }
            } receiveValue: { response in
                CardSet.remoteSets = response.sets
                HeroClass.remoteHeroClasses = response.classes
                CardRarity.remoteCardRarities = response.rarities
                callback(false)
            }
            .store(in: &subscriptions)
    }
    
    func getCards(
        searchText: String,
        cardSet: CardSet?,
        manaCost: Int?,
        attack: Int?,
        health: Int?,
        heroClass: HeroClass?,
        cardRarity: CardRarity?,
        shouldShowUncollectibleCards: Bool,
        sortOption: CardSortOption,
        sortDirection: CardSortDirection,
        page: Int,
        pageSize: Int
    ) -> (any Publisher<CardsResponse, Error>) {
        var url = baseUrl.appending(path: "/hearthstone/cards")
        let showCollectibleCards = shouldShowUncollectibleCards ? "0,1" : "1"
        url.append(queryItems: [
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "locale", value: "en_US"),
            URLQueryItem(name: "page", value: String(page + 1)),
            URLQueryItem(name: "pageSize", value: String(pageSize)),
            URLQueryItem(name: "sort", value: "\(sortOption.id):\(sortDirection.id)"),
            URLQueryItem(name: "textFilter", value: searchText),
            URLQueryItem(name: "collectible", value: showCollectibleCards)
        ])
        if let cardSet = cardSet {
            url.append(queryItems: [URLQueryItem(name: "set", value: cardSet.slug)])
        }
        if let heroClass = heroClass {
            url.append(queryItems: [URLQueryItem(name: "class", value: heroClass.slug)])
        }
        if let cardRarity = cardRarity {
            url.append(queryItems: [URLQueryItem(name: "rarity", value: cardRarity.slug)])
        }
        if let manaCost = manaCost {
            url.append(queryItems: [URLQueryItem(name: "manaCost", value: String(manaCost))])
        }
        if let attack = attack {
            url.append(queryItems: [URLQueryItem(name: "attack", value: String(attack))])
        }
        if let health = health {
            url.append(queryItems: [URLQueryItem(name: "health", value: String(health))])
        }
        return session.dataTaskPublisher(for: url)
            .subscribe(on: queue)
            .map({
                debugPrint(String(data: $0.data, encoding: .utf8) ?? "")
                return $0.data
            })
            .decode(type: CardsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
    }
}
