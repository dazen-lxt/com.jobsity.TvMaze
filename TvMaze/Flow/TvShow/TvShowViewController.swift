//
//  TvShowViewController.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import UIKit

class TvShowViewController: UIViewController {

    // MARK: - IBOutlets -
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Internal Properties -
    var tvShowViewModel: TvShowViewModel?
    var interactor: TvShowBusinessLogic?
    var episodes: [SeasonViewModel] = []
    var isFavorite: Bool = true
    
    // MARK: - Private Properties -
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(
        top: 20.0,
        left: 20.0,
        bottom: 20.0,
        right: 20.0)
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTvShow()
        interactor?.getShowDetail(id: tvShowViewModel?.id ?? 0)
        interactor?.getEpisodes(id: tvShowViewModel?.id ?? 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.checkIfIsFavorite(id: tvShowViewModel?.id ?? 0)
    }
    
    static func assembleModule(viewModel: TvShowViewModel) -> TvShowViewController {
        let viewController: TvShowViewController = TvShowViewController()
        viewController.title = viewModel.name
        viewController.tvShowViewModel = viewModel
        let interactor: TvShowInteractor = TvShowInteractor()
        let presenter: TvShowPresenter = TvShowPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
        return viewController
    }

    // MARK: - Private Methods -
    private func setupTvShow() {
        genresLabel.text = tvShowViewModel?.genres
        summaryLabel.setHTMLFromString(htmlText: tvShowViewModel?.summary ?? "")
        summaryLabel.textColor = genresLabel.textColor
        timeLabel.text = tvShowViewModel?.time
        if let imageUrl = tvShowViewModel?.imageUrl {
            posterImageView.af.setImage(withURL: imageUrl)
        }
    }
    
    private func setupCollectionView() {
        let nibName: String = "EpisodeCollectionViewCell"
        collectionView.register(
            UINib(
                nibName: nibName,
                bundle: nil
            ),
            forCellWithReuseIdentifier: nibName
        )
        let headerNibName: String = "EpisodeHeaderCollectionViewCell"
        collectionView.register(
            UINib(
                nibName: headerNibName,
                bundle: nil
            ),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerNibName
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    @IBAction func addFavorite(_ sender: Any) {
        guard let tvShowViewModel = tvShowViewModel else { return }
        interactor?.toggleFavorite(show: tvShowViewModel)
    }
}

// MARK: - TvShowDisplayLogic Implementation -
extension TvShowViewController: TvShowDisplayLogic {
    func displayShowDetail(_ show: TvShowViewModel) {
        self.tvShowViewModel = show
        setupTvShow()
    }
    
    func displayEpisodes(_ episodesBySeason: [SeasonViewModel]) {
        self.episodes = episodesBySeason
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        collectionHeightConstraint.constant = collectionView.contentSize.height
    }
    
    func displayIsFavorite(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
        if isFavorite {
            favoriteButton.setTitle("Favorite", for: .normal)
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setTitle("Add to Favorites", for: .normal)
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}

// MARK: - TvShowDisplayLogic Implementation -
extension TvShowViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
          case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
              ofKind: kind,
              withReuseIdentifier: "\(EpisodeHeaderCollectionViewCell.self)",
              for: indexPath) as? EpisodeHeaderCollectionViewCell else {
                fatalError("Invalid element type")
            }
            headerView.configure(season: episodes[indexPath.section].season)
            return headerView
          default:
            fatalError("Invalid element type")
          }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30.0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes[section].episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EpisodeCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: episodes[indexPath.section].episodes[indexPath.row], showImageUrl: tvShowViewModel?.imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem * 0.6 + 40
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let season = episodes[indexPath.section]
        var episode = season.episodes[indexPath.row]
        if episode.imageUrl == nil {
            episode.imageUrl = tvShowViewModel?.imageUrl
        }
        let nextViewController = EpisodeDetailViewController.assembleModule(
            viewModel: episode,
            season: season.season
        )
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
