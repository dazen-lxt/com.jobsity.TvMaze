//
//  PeoplePresenter.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

class PeoplePresenter {
    
    // MARK: - Internal Properties -
    weak var view: PeopleDisplayLogic?
    
}

// MARK: - PeoplePresentationLogic Implementation -
extension PeoplePresenter: PeoplePresentationLogic {
    
    func presentPeople(_ people: [PersonModel]) {
        let viewModels: [PersonViewModel] = people.compactMap { model in
            return PersonViewModel(
                id: model.person.id,
                name: model.person.name,
                country: model.person.country?.name ?? "",
                imageUrl: URL(string: model.person.image?.medium ?? ""),
                dates: "\(model.person.birthday ?? "") - \(model.person.deathday ?? "")"
            )
        }
        view?.displayPeople(viewModels)
    }
    
}
