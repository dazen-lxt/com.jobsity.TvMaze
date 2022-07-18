//
//  EpisodeHeaderCollectionViewCell.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import UIKit

class EpisodeHeaderCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets -
    @IBOutlet private weak var seasonLabel: UILabel!
    
    // MARK: - Lifecycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Internal Methods -
    func configure(season: Int) {
        seasonLabel.text = "Season \(season)"
    }
}
