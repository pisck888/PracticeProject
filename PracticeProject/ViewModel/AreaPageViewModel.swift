//
//  AreaPageViewModel.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/18.
//

import Foundation
import RxSwift

class AreaPageViewModel {

    let disposeBag = DisposeBag()

    let isLoading: PublishSubject<Bool> = PublishSubject()

    let areaData: PublishSubject<[AreaPageCellViewModel]> = PublishSubject()

    func fetchAreaData() {
        isLoading.onNext(true)
        APIService.shared.getAreaData().subscribe { areaData in
            self.convertDataToAreaViewModel(data: areaData)
            self.isLoading.onNext(false)
        } onFailure: { error in
            print(error)
        }.disposed(by: disposeBag)
    }

    private func convertDataToAreaViewModel(data: AreaData) {
        var cellViewModels: [AreaPageCellViewModel] = []
        let areaDataArray = data.result.results
        for area in areaDataArray {

            let memo = area.memo == "" ? "無休館資訊" : area.memo

            let cellViewModel = AreaPageCellViewModel(imageUrl: area.picURL, title: area.name, info: area.info, memo: memo,category: area.category)
            cellViewModels.append(cellViewModel)
        }
        self.areaData.onNext(cellViewModels)
    }
}
