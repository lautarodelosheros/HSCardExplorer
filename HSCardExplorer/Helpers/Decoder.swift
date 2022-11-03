//
//  Decoder.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 02/11/2022.
//

import Foundation

class Decoder<T: Codable> {
    func decode(from data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            debugPrint(error)
            return nil
        }
    }
}
