//
//  AreaDetailViewController.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/18.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AreaDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = AreaDetailPageViewModel()

    let disposeBag = DisposeBag()

    let dataSource = RxTableViewSectionedReloadDataSource<MultipleSectionModel> { dataSource, tableView, indexPath, item in
        switch dataSource[indexPath] {
        case let .AreaPageCellViewModel(areaDetailData):
            let cell = tableView.dequeueReusableCell(withIdentifier: "AreaDetailTableViewCell", for: indexPath) as? AreaDetailTableViewCell
            cell?.setup(viewModel: areaDetailData)
            return cell ?? AreaDetailTableViewCell()
        case let .PlantCellViewModel(plantListData):
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlantListTableViewCell", for: indexPath) as? PlantListTableViewCell
            cell?.setup(viewModel: plantListData)
            return cell ?? PlantListTableViewCell()
        }
    } titleForHeaderInSection: {
        dataSource, index in
        let section = dataSource[index]
        return section.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        setupBindings()
        viewModel.fetchPlantData()
    }

    override func viewDidLayoutSubviews() {
        activityIndicator.center = view.center
    }

    func setupBindings() {
        viewModel.isLoading.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
        viewModel.isLoading.bind(to: tableView.rx.isHidden).disposed(by: disposeBag)

        viewModel.sectionsData.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)

        tableView.rx.modelSelected(SectionItem.self).subscribe { [weak self] viewModel in
            switch viewModel.element {
            case let .PlantCellViewModel(viewModel):
                self?.performSegue(withIdentifier: "SegueToPlantDetailPage", sender: viewModel)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToPlantDetailPage" {
            guard let vc = segue.destination as? PlantDetailViewController else {
                return
            }
            if let viewModel = sender as? PlantCellViewModel {
                vc.viewModel.onNext([viewModel])
            }
            vc.navigationItem.title = (sender as? PlantCellViewModel)?.nameCh
        }
    }

    @IBAction func pressBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension AreaDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 20
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 20, width: 100, height: 20))
        titleLabel.text = "植物資料"
        headerView.backgroundColor = .white
        headerView.addSubview(titleLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 60
        }
    }
}
