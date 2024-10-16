//
//  IPInfo.swift
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//

import UIKit

struct PublicIPDetail: Codable {
    let ip: String
}
struct GeoInfo: Codable {
    let ip: String
    let city: String?
    let region: String?
    let country: String?
    let loc: String?
    let postal: String?
    let timezone: String?
    let org: String?
    let carrier: String?
}
