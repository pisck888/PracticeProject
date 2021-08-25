//
//  APIManager.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/17.
//

import Foundation
import Alamofire
import RxSwift

class APIService {

    static let shared = APIService()

    func getAreaData() -> Single<AreaData> {

        return Single.create { single -> Disposable in

            let url = "https://data.taipei/api/v1/dataset/5a0e5fbb-72f8-41c6-908e-2fb25eff9b8a?scope=resourceAquire"

            AF.request(url, method: .get, encoding: URLEncoding.default)
                .responseDecodable(of: AreaData.self) { response in
                    switch response.result {
                    case .success(let areaData):
                        single(.success(areaData))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }

    func getPlantData() -> Single<PlantData> {

        return Single.create { single -> Disposable in

            let url = "https://data.taipei/api/v1/dataset/f18de02f-b6c9-47c0-8cda-50efad621c14?scope=resourceAquire"

            let parameters = ["limit": 10]

            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
                .responseDecodable(of: PlantData.self) { response in
                    switch response.result {
                    case .success(let plantData):
                        single(.success(plantData))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
}
