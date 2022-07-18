//
//  TvListPresenter.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

class TvListPresenter {
    
    // MARK: - Internal Properties -
    weak var view: TvListDisplayLogic?
    
}

// MARK: - TvListPresentationLogic Implementation -
extension TvListPresenter: TvListPresentationLogic {
    
    func presentShows(_ shows: [TvShowModel]) {
        presentShows(shows.map { $0.show })
    }
    
    func presentShows(_ shows: [TvShowInfoModel]) {
        let viewModels: [TvShowViewModel] = shows.compactMap { model in
            return TvShowViewModel(
                id: model.id,
                name: model.name,
                genres: model.genres.joinWords(),
                imageUrl: URL(string: model.image?.medium ?? ""),
                summary: model.summary ?? "",
                time: ""
            )
        }
        view?.displayShows(viewModels)
    }
    
}
