//
//  EpisodeDetailViewController.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - IBOutlets -
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Internal Properties -
    var episode: EpisodeViewModel?
    var season: Int = 0
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEpisodeInfo()
    }
    
    static func assembleModule(viewModel: EpisodeViewModel, season: Int) -> EpisodeDetailViewController {
        let viewController: EpisodeDetailViewController = EpisodeDetailViewController()
        viewController.title = viewModel.name
        viewController.episode = viewModel
        viewController.season = season
        return viewController
    }

    // MARK: - Private Methods -
    private func setupEpisodeInfo() {
        nameLabel.text = episode?.name
        numberLabel.text = "\(season)x\(episode?.number ?? 0)"
        summaryLabel.setHTMLFromString(htmlText: episode?.summary ?? "")
        summaryLabel.textColor = numberLabel.textColor
        if let imageUrl = episode?.imageUrl {
            posterImageView.af.setImage(withURL: imageUrl)
        }
    }
}
