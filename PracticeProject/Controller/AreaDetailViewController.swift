//
//  AreaDetailViewController.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/18.
//

import UIKit

class AreaDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel = AreaDetailPageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.fetchPlantData()
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

extension AreaDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return viewModel.numberOfCells
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AreaDetailTableViewCell", for: indexPath) as? AreaDetailTableViewCell
            if let viewModel = viewModel.areaDetail {
                cell?.setup(viewModel: viewModel)
            }
            return cell ?? AreaDetailTableViewCell()
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlantListTableViewCell", for: indexPath) as? PlantListTableViewCell
            let viewModel = viewModel.getCellViewModel(at: indexPath)
            cell?.setup(viewModel: viewModel)
            return cell ?? PlantListTableViewCell()
        }
    }
}

extension AreaDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        performSegue(withIdentifier: "SegueToPlantDetailPage", sender: cellViewModel)
    }
}
