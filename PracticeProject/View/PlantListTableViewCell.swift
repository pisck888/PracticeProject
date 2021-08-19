//
//  PlantListTableViewCell.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/18.
//

import UIKit
import Kingfisher

class PlantListTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alsoKnownLabel: UILabel!

    func setup(viewModel: PlantCellViewModel) {
        let url = URL(string: viewModel.imageURL)
        mainImage.kf.setImage(with: url)
        titleLabel.text = viewModel.nameCh
        alsoKnownLabel.text = viewModel.alsoKnown
        self.selectionStyle = .none
    }
}
