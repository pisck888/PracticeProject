//
//  ViewController.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/17.
//

import UIKit
import RxSwift
import RxCocoa

class AreaListViewController: UIViewController {

    let viewModel = AreaPageViewModel()

    let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBindings()
        viewModel.fetchAreaData()
    }

    private func setupBindings() {
        viewModel.isLoading.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
        viewModel.isLoading.bind(to: tableView.rx.isHidden).disposed(by: disposeBag)

        viewModel.areaData.bind(to: tableView.rx.items(cellIdentifier: "areaCell", cellType: AreaListTableViewCell.self)) { row, viewModel, cell in
            cell.setup(viewModel: viewModel)
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(AreaPageCellViewModel.self).subscribe { [weak self] viewModel in
            self?.performSegue(withIdentifier: "SegueToAreaDetailPage", sender: viewModel.element)
        }.disposed(by: disposeBag)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToAreaDetailPage" {
            guard let vc = segue.destination as? AreaDetailViewController else {
                return
            }
            vc.viewModel.areaDetail = sender as? AreaPageCellViewModel
            vc.navigationItem.title = (sender as? AreaPageCellViewModel)?.title
        }
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
    }
}
