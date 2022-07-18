//
//  TvShowTableViewCell.swift
//  TvMaze
//
//  Created by Carlos on 14/07/22.
//

import UIKit
import AlamofireImage

class TvShowTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var titleLabel: UILabel!
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
    func configure(with viewModel: TvShowViewModel) {
        titleLabel.text = viewModel.name
        subtitleLabel.text = viewModel.genres
        if let imageUrl = viewModel.imageUrl {
            showImageView.af.setImage(withURL: imageUrl)
        }
    }
    
}
