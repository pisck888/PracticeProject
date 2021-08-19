//
//  APIManager.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/17.
//

import Foundation
import Alamofire

class APIService {

    static let shared = APIService()

    func getAreaData(completionHandler: @escaping (AreaData) -> Void) {

        let url = "https://data.taipei/api/v1/dataset/5a0e5fbb-72f8-41c6-908e-2fb25eff9b8a?scope=resourceAquire"

        AF.request(url, method: .get, encoding: URLEncoding.default)
            .responseDecodable(of: AreaData.self) { response in
                switch response.result {
                case .success(let areaData):
                    completionHandler(areaData)
                case .failure(let error):
                    print(error)
                }
            }
    }

    func getPlantData(completionHandler: @escaping (PlantData) -> Void) {

        let url = "https://data.taipei/api/v1/dataset/f18de02f-b6c9-47c0-8cda-50efad621c14?scope=resourceAquire"

        let parameters = ["limit": 10]

        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .responseDecodable(of: PlantData.self) { response in
                switch response.result {
                case .success(let plantData):
                    completionHandler(plantData)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
