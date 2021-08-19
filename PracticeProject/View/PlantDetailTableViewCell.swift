//
//  PlantDetailTableViewCell.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/19.
//

import UIKit
import Kingfisher

class PlantDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameChLabel: UILabel!
    @IBOutlet weak var nameEnLabel: UILabel!
    @IBOutlet weak var alsoKnownLabel: UILabel!
    @IBOutlet weak var briefLabel: UILabel!
    @IBOutlet weak var featureLabel: UILabel!
    @IBOutlet weak var functionApplicationLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!

    func setup(viewModel: PlantCellViewModel) {
        let url = URL(string: viewModel.imageURL)
        mainImage.kf.setImage(with: url)
        nameChLabel.text = viewModel.nameCh
        nameEnLabel.text = viewModel.nameEn
        alsoKnownLabel.text = viewModel.alsoKnown
        briefLabel.text = viewModel.brief
        featureLabel.text = viewModel.feature
        functionApplicationLabel.text = viewModel.functionApplication
        updateLabel.text = "最後更新：\(viewModel.updateTime)"
    }
}
