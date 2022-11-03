//
//  AccessTokenResponse.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 03/11/2022.
//

import Foundation

struct AccessTokenResponse: Codable {
    
    let accessToken: String
    
    private enum CodingKeys: String, CodingKey {
      case accessToken = "access_token"
    }
}
