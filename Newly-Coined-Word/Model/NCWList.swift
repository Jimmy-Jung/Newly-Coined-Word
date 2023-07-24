//
//  NCWList.swift
//  Newly-Coined-Word
//
//  Created by 정준영 on 2023/07/24.
//

import Foundation

struct NCWList: Codable {
    let totalCount: Int
    let lists: [NCW]
}

struct NCW: Codable {
    let name: String
    let description: String
}
