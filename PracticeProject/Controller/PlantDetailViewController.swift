//
//  PlantDetailViewController.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/19.
//

import UIKit

class PlantDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: PlantCellViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func pressBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension PlantDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlantDetailTableViewCell", for: indexPath) as? PlantDetailTableViewCell

        if let viewModel = viewModel {
            cell?.setup(viewModel: viewModel)
        }
        return cell ?? PlantDetailTableViewCell()
    }
}
