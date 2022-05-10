//
//  CoinData.swift
//  ByteCoin
//
//  Created by Rafael Benjamin on 10/05/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

// MARK: - CoinData
struct CoinData: Codable {
    var time, assetIDBase, assetIDQuote: String?
    var rate: Double?
    var srcSideBase: [SrcSideBase]?

    enum CodingKeys: String, CodingKey {
        case time
        case assetIDBase = "asset_id_base"
        case assetIDQuote = "asset_id_quote"
        case rate
        case srcSideBase = "src_side_base"
    }
}

// MARK: - SrcSideBase
struct SrcSideBase: Codable {
    var time, asset: String?
    var rate, volume: Double?
}
