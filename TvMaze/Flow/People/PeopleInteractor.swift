//
//  PeopleInteractor.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

class PeopleInteractor {
    
    // MARK: - Internal Properties -
    var presenter: PeoplePresentationLogic?
    
}

// MARK: - PeopleBusinessLogic Implementation -
extension PeopleInteractor: PeopleBusinessLogic {
    
    func searchPeople(byName name: String) {
        let req = Endpoint.People(name: name)
        ApiClient.shared.doRequest(req: req) {
            [weak self] (result: ApiResult<[PersonModel]>) in
            switch(result) {
            case .success(let data):
                self?.presenter?.presentPeople(data)
            default:
                break
            }
        }
    }
    
}
