//
//  AreaDetailPageViewModel.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/18.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class AreaDetailPageViewModel {

    var areaDetail: AreaPageCellViewModel?

    let disposeBag = DisposeBag()

    let isLoading: PublishSubject<Bool> = PublishSubject()

    var sections: [MultipleSectionModel] = []

    let sectionsData: PublishSubject<[MultipleSectionModel]> = PublishSubject()

    func fetchPlantData() {
        isLoading.onNext(true)
        APIService.shared.getPlantData().subscribe { plantData in
            self.convertDataToPlantViewModel(data: plantData)
            self.sectionsData.onNext(self.sections)
            self.isLoading.onNext(false)
        } onFailure: { error in
            print(error)
        }.disposed(by: disposeBag)
    }

    private func convertDataToPlantViewModel(data: PlantData) {
        var cellViewModels: [PlantCellViewModel] = []
        let plantDataArray = data.result.results
        
        for plant in plantDataArray {
            let cellViewModel = PlantCellViewModel(imageURL: plant.picURL, nameCh: plant.nameCh, alsoKnown: plant.alsoKnown, nameEn: plant.nameEn, brief: plant.brief, feature: plant.feature, functionApplication: plant.functionApplication, updateTime: plant.update)
            cellViewModels.append(cellViewModel)
        }
        if let areaDetail = areaDetail {
            sections = [
                .AreaDetailSection(title: "", items: [.AreaPageCellViewModel(viewModel: areaDetail)]),
                .PlantListSection(title: "植物資料", items: cellViewModels.map {
                    .PlantCellViewModel(viewModel: $0)
                })
            ]
        }
    }
}


enum MultipleSectionModel {
    case AreaDetailSection(title: String, items: [SectionItem])
    case PlantListSection(title: String, items: [SectionItem])
}

enum SectionItem {
    case AreaPageCellViewModel(viewModel: AreaPageCellViewModel)
    case PlantCellViewModel(viewModel: PlantCellViewModel)
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem

    var items: [SectionItem] {
        switch self {
        case .AreaDetailSection(title: _, items: let items):
            return items.map { $0 }
        case .PlantListSection(title: _, items: let items):
            return items.map { $0 }
        }
    }

    var title: String {
        switch self {
        case .AreaDetailSection(title: let title, items: _):
            return title
        case .PlantListSection(title: let title, items: _):
            return title
        }
    }


    init(original: MultipleSectionModel, items: [Item]) {
        switch original {
        case let .AreaDetailSection(title: title, items: _):
            self = .AreaDetailSection(title: title, items: items)
        case let .PlantListSection(title: title, items: _):
            self = .PlantListSection(title: title, items: items)
        }
    }
}
