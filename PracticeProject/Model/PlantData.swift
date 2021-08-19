//
//  PlantData.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/18.
//

import Foundation

// MARK: - PlantData
struct PlantData: Codable {
    let result: PlantDataResults
}

// MARK: - PlantDataResults
struct PlantDataResults: Codable {
    let results: [PlantDataResult]
}

// MARK: - PlantDataResult
struct PlantDataResult: Codable {
    let picURL: String
    let nameCh: String
    let alsoKnown: String
    let nameEn: String
    let brief: String
    let feature: String
    let functionApplication: String
    let update: String

    enum CodingKeys: String, CodingKey {
        case picURL = "F_Pic01_URL"
        case nameCh = "F_Name_Ch"
        case alsoKnown = "F_AlsoKnown"
        case nameEn = "F_Name_En"
        case brief = "F_Brief"
        case feature = "F_Feature"
        case functionApplication = "F_Function＆Application"
        case update = "F_Update"
    }
}
