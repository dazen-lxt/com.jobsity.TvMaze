//
//  PeopleContract.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

protocol PeopleBusinessLogic: AnyObject {
    func searchPeople(byName name: String)
}

protocol PeoplePresentationLogic: AnyObject {
    func presentPeople(_ people: [PersonModel])
}

protocol PeopleDisplayLogic: AnyObject {
    func displayPeople(_ people: [PersonViewModel])
}

