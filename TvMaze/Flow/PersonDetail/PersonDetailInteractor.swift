//
//  PersonDetailInteractor.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

class PersonDetailInteractor {
    
    // MARK: - Internal Properties -
    var presenter: PersonDetailPresentationLogic?
    
}

// MARK: - PersonDetailBusinessLogic Implementation -
extension PersonDetailInteractor: PersonDetailBusinessLogic {
    
    func getShowsByPerson(id: Int) {
        let req = Endpoint.CastCredit(idPerson: id)
        ApiClient.shared.doRequest(req: req) {
            [weak self] (result: ApiResult<[CharacterModel]>) in
            switch(result) {
            case .success(let data):
                self?.presenter?.presentShows(data)
            default:
                break
            }
        }
    }
    
}
