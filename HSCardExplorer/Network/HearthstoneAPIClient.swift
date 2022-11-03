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
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        session = URLSession(configuration: configuration)
    }
    
    func getToken(callback: @escaping () -> Void) {
        let url = URL(string: "https://oauth.battle.net/token")!
            .appending(queryItems: [URLQueryItem(name: "grant_type", value: "client_credentials")])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(Data(HearthstoneAPIKey.secret.utf8).base64EncodedString())", forHTTPHeaderField: "Authorization")
        session.dataTaskPublisher(for: request)
            .subscribe(on: queue)
            .map({ $0.data })
            .decode(type: AccessTokenResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    debugPrint("Success")
                case .failure(let error):
                    debugPrint(error)
                }
            } receiveValue: { response in
                self.accessToken = response.accessToken
                callback()
            }
            .store(in: &subscriptions)
    }
    
    func getCards(
        shouldShowUncollectibleCards: Bool,
        sortOption: CardSortOption,
        sortDirection: CardSortDirection,
        page: Int,
        pageSize: Int
    ) -> (any Publisher<CardsResponse, Error>)? {
        var url = baseUrl.appending(path: "/hearthstone/cards")
        let showCollectibleCards = shouldShowUncollectibleCards ? "0,1" : "1"
        url.append(queryItems: [
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "locale", value: "en_US"),
            URLQueryItem(name: "page", value: String(page + 1)),
            URLQueryItem(name: "pageSize", value: String(pageSize)),
            URLQueryItem(name: "sort", value: "\(sortOption.id):\(sortDirection.id)"),
            URLQueryItem(name: "collectible", value: showCollectibleCards)
        ])
        return session.dataTaskPublisher(for: url)
            .subscribe(on: queue)
            .map({ $0.data })
            .decode(type: CardsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
    }
}
