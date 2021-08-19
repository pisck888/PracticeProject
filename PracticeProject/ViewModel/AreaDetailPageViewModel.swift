//
//  AreaDetailPageViewModel.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/18.
//

import Foundation

class AreaDetailPageViewModel {

    var areaDetail: AreaPageCellViewModel?

    var reloadTableViewClosure: (() -> Void)?

    private var cellViewModels: [PlantCellViewModel] = [] {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }

    func fetchPlantData() {
        APIService.shared.getPlantData { plantData in
            self.convertDataToPlantViewModel(data: plantData)
        }
    }

    private func convertDataToPlantViewModel(data: PlantData) {
        let plantDataArray = data.result.results
        
        for plant in plantDataArray {
            let cellViewModel = PlantCellViewModel(imageURL: plant.picURL, nameCh: plant.nameCh, alsoKnown: plant.alsoKnown, nameEn: plant.nameEn, brief: plant.brief, feature: plant.feature, functionApplication: plant.functionApplication, updateTime: plant.update)
            cellViewModels.append(cellViewModel)
        }
    }

    func getCellViewModel(at indexPath: IndexPath) -> PlantCellViewModel {
        return cellViewModels[indexPath.row]
    }
}
