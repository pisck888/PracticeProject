//
//  AreaData.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/17.
//

import Foundation

// MARK: - AreaData
struct AreaData: Codable {
    let result: AreaDataResults
}

// MARK: - AreaDataResults
struct AreaDataResults: Codable {
    let results: [AreaDataResult]
}

// MARK: - AreaDataResult
struct AreaDataResult: Codable {
    let picURL: String
    let info: String
    let category: String
    let name: String
    let memo: String

    enum CodingKeys: String, CodingKey {
        case picURL = "E_Pic_URL"
        case info = "E_Info"
        case category = "E_Category"
        case name = "E_Name"
        case memo = "E_Memo"
    }
}
