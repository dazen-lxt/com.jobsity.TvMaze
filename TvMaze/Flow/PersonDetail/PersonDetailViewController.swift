//
//  PersonDetailViewController.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import UIKit

class PersonDetailViewController: UIViewController {

    // MARK: - IBOutlets -
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var datesLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Internal Properties -
    var viewModel: PersonViewModel?
    var interactor: PersonDetailBusinessLogic?
    var shows: [TvShowViewModel] = []
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPerson()
        interactor?.getShowsByPerson(id: viewModel?.id ?? 0)
    }
    
    static func assembleModule(viewModel: PersonViewModel) -> PersonDetailViewController {
        let viewController: PersonDetailViewController = PersonDetailViewController()
        viewController.title = viewModel.name
        viewController.viewModel = viewModel
        let interactor: PersonDetailInteractor = PersonDetailInteractor()
        let presenter: PersonDetailPresenter = PersonDetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
        return viewController
    }

    // MARK: - Private Methods -
    private func setupPerson() {
        nameLabel.text = viewModel?.name
        countryLabel.text = viewModel?.country
        datesLabel.text = viewModel?.dates
        if let imageUrl = viewModel?.imageUrl {
            posterImageView.af.setImage(withURL: imageUrl)
        }
    }
    
    private func setupTableView() {
        let nibName: String = "TvShowTableViewCell"
        tableView.register(
            UINib(
                nibName: nibName,
                bundle: nil
            ),
            forCellReuseIdentifier: nibName
        )
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - TvShowDisplayLogic Implementation -
extension PersonDetailViewController: PersonDetailDisplayLogic {
    
    func displayShows(_ shows: [TvShowViewModel]) {
        self.shows = shows
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableHeightConstraint.constant = tableView.contentSize.height
    }
    
}

// MARK: - TvShowDisplayLogic Implementation -
extension PersonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TvShowTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: shows[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TvShowViewController.assembleModule(viewModel: shows[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
