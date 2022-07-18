//
//  PeopleTableViewController.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    // MARK: - Internal Properties -
    var viewModel: [PersonViewModel] = []
    var interactor:  PeopleBusinessLogic?
    var term: String?
    var searchController : UISearchController!
        
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        createSearchBar()
    }
    
    static func assembleModule() -> PeopleTableViewController {
        let viewController: PeopleTableViewController = PeopleTableViewController()
        viewController.title = "People"
        let interactor: PeopleInteractor = PeopleInteractor()
        let presenter: PeoplePresenter = PeoplePresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
        return viewController
    }
    
    // MARK: - Private Methods -
    private func registerCells() {
        let nibName: String = "PersonTableViewCell"
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
            interactor?.searchPeople(byName: term)
        }
    }
}

// MARK: - PeopleDisplayLogic Implementation -
extension PeopleTableViewController: PeopleDisplayLogic {
    
    func displayPeople(_ people: [PersonViewModel]) {
        viewModel = people
        tableView.reloadData()
    }
}

// MARK: - UISearchResultsUpdating Implementation -
extension PeopleTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(doSearch), object: nil)
        self.term = searchController.searchBar.text
        perform(#selector(doSearch), with: nil, afterDelay: 0.5)
    }
}

// MARK: - UITableViewController Implementation -
extension PeopleTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PersonTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PersonDetailViewController.assembleModule(viewModel: viewModel[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
