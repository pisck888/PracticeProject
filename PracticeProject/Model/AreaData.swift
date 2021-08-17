//
//  AreaData.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/17.
//

import Foundation

// MARK: - AreaData
struct AreaData: Codable {
    let result: AreaDataResult
}

// MARK: - AreaDataResult
struct AreaDataResult: Codable {
    let limit, offset, count: Int
    let results: [ResultElement]
}

// MARK: - ResultElement
struct ResultElement: Codable {
    let ePicURL: String
    let eInfo: String
    let eCategory: String
    let eName: String
    let eMemo: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case ePicURL = "E_Pic_URL"
        case eInfo = "E_Info"
        case eCategory = "E_Category"
        case eName = "E_Name"
        case eMemo = "E_Memo"
        case id = "_id"
    }
}
