//
//  AreaPageViewModel.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/18.
//

import Foundation

class AreaPageViewModel {

    var reloadTableViewClosure: (() -> Void)?

    var updateLoadingStatus: (() -> Void)?

    private var cellViewModels: [AreaPageCellViewModel] = [] {
        didSet {
            reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }

    var isLoading = false {
        didSet {
            updateLoadingStatus?()
        }
    }

    func fetchAreaData() {
        isLoading = true
        APIService.shared.getAreaData { areaData in
            self.convertDataToAreaViewModel(data: areaData)
            self.isLoading = false
        }
    }

    private func convertDataToAreaViewModel(data: AreaData) {
        let areaDataArray = data.result.results
        for area in areaDataArray {

            let memo = area.memo == "" ? "無休館資訊" : area.memo

            let cellViewModel = AreaPageCellViewModel(imageUrl: area.picURL, title: area.name, info: area.info, memo: memo,category: area.category)
            cellViewModels.append(cellViewModel)
        }
    }

    func getCellViewModel(at indexPath: IndexPath) -> AreaPageCellViewModel {
        return cellViewModels[indexPath.row]
    }

}
