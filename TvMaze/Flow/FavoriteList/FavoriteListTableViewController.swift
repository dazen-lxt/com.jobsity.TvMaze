//
//  FavoriteListTableViewController.swift
//  FavoriteMaze
//
//  Created by Carlos on 17/07/22.
//

import UIKit

class FavoriteListTableViewController: UITableViewController {
    
    // MARK: - Internal Properties -
    var viewModel: [TvShowViewModel] = []
    var interactor: FavoriteListBusinessLogic?
        
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.listFavorites()
    }
    
    static func assembleModule() -> FavoriteListTableViewController {
        let viewController: FavoriteListTableViewController = FavoriteListTableViewController()
        viewController.title = "Favorite Shows"
        let interactor: FavoriteListInteractor = FavoriteListInteractor()
        let presenter: FavoriteListPresenter = FavoriteListPresenter()
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
    
    private func confirmDelete(id: Int) {
        let alert = UIAlertController(
            title: "Delete Favorite",
            message: "Are you sure you want to delete this favorite?",
            preferredStyle: .actionSheet
        )
        
        let deleteAction = UIAlertAction(
            title: "Delete",
            style: .destructive,
            handler: { [weak self] _ in
                self?.tableView.endUpdates()
                self?.interactor?.deleteFavorite(id: id)
                
            }
        )
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        )
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(
            x: self.view.bounds.size.width / 2.0,
            y: self.view.bounds.size.height / 2.0,
            width: 1.0,
            height: 1.0)
        
        self.present(alert, animated: true, completion: nil)
    
    }
    
}

// MARK: - FavoriteListDisplayLogic Implementation -
extension FavoriteListTableViewController: FavoriteListDisplayLogic {
    
    func displayShows(_ shows: [TvShowViewModel]) {
        viewModel = shows
        tableView.reloadData()
    }
}

// MARK: - UITableViewController Implementation -
extension FavoriteListTableViewController {
    
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            confirmDelete(id: viewModel[indexPath.row].id)
        }
    }
}
