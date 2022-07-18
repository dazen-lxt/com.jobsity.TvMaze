//
//  EpisodeCollectionViewCell.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets -
    @IBOutlet private weak var episodeImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Lifecycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Internal Methods -
    func configure(with viewModel: EpisodeViewModel, showImageUrl: URL?) {
        nameLabel.text = "\(viewModel.number). \(viewModel.name)"
        if let imageUrl = viewModel.imageUrl {
            episodeImageView.af.setImage(withURL: imageUrl)
        } else if let imageUrl = showImageUrl {
            episodeImageView.af.setImage(withURL: imageUrl)
        }
    }
}
