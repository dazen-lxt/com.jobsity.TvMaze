//
//  TvListTableViewController.swift
//  TvMaze
//
//  Created by Carlos on 14/07/22.
//

import UIKit

class TvListTableViewController: UITableViewController {
    
    // MARK: - Internal Properties -
    var viewModel: [TvShowViewModel] = []
    var interactor: TvListBusinessLogic?
    var term: String?
    var searchController : UISearchController!
        
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        createSearchBar()
        interactor?.getShows(byPage: 1)
    }
    
    static func assembleModule() -> TvListTableViewController {
        let viewController: TvListTableViewController = TvListTableViewController()
        viewController.title = "Tv Shows"
        let interactor: TvListInteractor = TvListInteractor()
        let presenter: TvListPresenter = TvListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
        return viewController
    }
    
    // MARK: - Private Methods -
    private func registerCells() {
        let nibName: String = "TvShowTableViewCell"
        tableView.register(
            UINib(
                nibName: nibName,
                bundle: nil
            ),
            forCellReuseIdentifier: nibName
        )
    }
    
    private func createSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = self.searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search by name"
        searchController.searchBar.autocapitalizationType = .none
        definesPresentationContext = true
    }
    
    @objc private func doSearch() {
        if let term = term {
            if term.isEmpty {
                interactor?.getShows(byPage: 1)
            } else {
                interactor?.searchShow(byName: term)
            }
        }
    }
}

// MARK: - TvListDisplayLogic Implementation -
extension TvListTableViewController: TvListDisplayLogic {
    
    func displayShows(_ shows: [TvShowViewModel]) {
        viewModel = shows
        tableView.reloadData()
    }
}

// MARK: - UISearchResultsUpdating Implementation -
extension TvListTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(doSearch), object: nil)
        self.term = searchController.searchBar.text
        perform(#selector(doSearch), with: nil, afterDelay: 0.5)
    }
}

// MARK: - UITableViewController Implementation -
extension TvListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TvShowTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TvShowViewController.assembleModule(viewModel: viewModel[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
