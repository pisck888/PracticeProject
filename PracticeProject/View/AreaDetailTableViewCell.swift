//
//  AreaDetailTableViewCell.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/18.
//

import UIKit
import Kingfisher

class AreaDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    func setup(viewModel: AreaPageCellViewModel) {
        let url = URL(string: viewModel.imageUrl)
        mainImage.kf.setImage(with: url)
        infoLabel.text = viewModel.info
        memoLabel.text = viewModel.memo
        categoryLabel.text = viewModel.category
        self.selectionStyle = .none
    }
}
