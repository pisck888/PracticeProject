//
//  CustomTableViewCell.swift
//  PracticeProject
//
//  Created by i_maxtsai on 2021/8/17.
//

import UIKit
import Kingfisher

class AreaListTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!

    func setup(viewModel: AreaPageCellViewModel) {
        let url = URL(string: viewModel.imageUrl)
        mainImage.kf.setImage(with: url)
        titleLabel.text = viewModel.title
        infoLabel.text = viewModel.info
        memoLabel.text = viewModel.memo
        self.selectionStyle = .none
    }
}
