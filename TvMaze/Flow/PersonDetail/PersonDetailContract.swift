//
//  PersonDetailContract.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

protocol PersonDetailBusinessLogic: AnyObject {
    func getShowsByPerson(id: Int)
}

protocol PersonDetailPresentationLogic: AnyObject {
    func presentShows(_ shows: [CharacterModel])
}

protocol PersonDetailDisplayLogic: AnyObject {
    func displayShows(_ shows: [TvShowViewModel])
}

