//
//  PersonDetailPresenter.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

class PersonDetailPresenter {
    
    // MARK: - Internal Properties -
    weak var view: PersonDetailDisplayLogic?
    
}

// MARK: - PersonDetailPresentationLogic Implementation -
extension PersonDetailPresenter: PersonDetailPresentationLogic {
    
    func presentShows(_ shows: [CharacterModel]) {
        let viewModels: [TvShowViewModel] = shows.compactMap { model in
            guard let show = model._embedded?.show else { return nil }
            return TvShowViewModel(
                id: show.id,
                name: show.name,
                genres: show.genres.joinWords(),
                imageUrl: URL(string: show.image?.medium ?? ""),
                summary: show.summary ?? "")
        }
        view?.displayShows(viewModels)
    }
    
}
