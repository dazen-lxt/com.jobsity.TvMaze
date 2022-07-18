//
//  PersonTableViewCell.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var showImageView: UIImageView!
    
    // MARK: - Lifecycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Internal Methods -
    func configure(with viewModel: PersonViewModel) {
        nameLabel.text = viewModel.name
        subtitleLabel.text = viewModel.country
        if let imageUrl = viewModel.imageUrl {
            showImageView.af.setImage(withURL: imageUrl)
        }
    }
    
}
