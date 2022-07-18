//
//  FavoriteListPresenter.swift
//  TvMaze
//
//  Created by Carlos on 17/07/22.
//

import CoreData

class FavoriteListPresenter {
    
    // MARK: - Internal Properties -
    weak var view: FavoriteListDisplayLogic?
    
}

// MARK: - FavoriteListPresentationLogic Implementation -
extension FavoriteListPresenter: FavoriteListPresentationLogic {
    
    func presentShows(_ shows: [NSManagedObject]) {
        let viewModels: [TvShowViewModel] = shows.map { object in
            let image: String = object.value(forKey: "imageUrl") as! String
            return TvShowViewModel(
                id: object.value(forKey: "id") as! Int,
                name: object.value(forKey: "name") as! String,
                genres: object.value(forKey: "genres") as! String,
                imageUrl: URL(string: image),
                summary: ""
            )
        }.sorted(by: { $0.name < $1.name })
        view?.displayShows(viewModels)
    }
    
}
