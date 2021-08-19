//
//  ViewController.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/17.
//

import UIKit

class AreaListViewController: UIViewController {

    let viewModel = AreaPageViewModel()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
             DispatchQueue.main.async {
               let isLoading = self?.viewModel.isLoading ?? false
               if isLoading {
                 self?.activityIndicator.startAnimating()
                 self?.tableView.alpha = 0.0
               }else {
                 self?.activityIndicator.stopAnimating()
                 self?.tableView.alpha = 1.0
               }
             }
           }


        viewModel.fetchAreaData()
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

extension AreaListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "areaCell", for: indexPath) as? AreaListTableViewCell

        let cellViewModel = viewModel.getCellViewModel(at: indexPath)

        cell?.setup(viewModel: cellViewModel)

        return cell ?? AreaListTableViewCell()
    }
}

extension AreaListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        performSegue(withIdentifier: "SegueToAreaDetailPage", sender: cellViewModel)
    }
}
