//
//  PlantDetailViewController.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/19.
//

import UIKit
import RxSwift
import RxCocoa

class PlantDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()

    let viewModel: ReplaySubject<[PlantCellViewModel]> = ReplaySubject.create(bufferSize: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    @IBAction func pressBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func setupBindings() {
        viewModel.bind(to: tableView.rx.items(cellIdentifier: "PlantDetailTableViewCell", cellType: PlantDetailTableViewCell.self)) { row, viewModel, cell in
            cell.setup(viewModel: viewModel)
        }.disposed(by: disposeBag)
    }
}
