//
//  TvListInteractor.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

class TvListInteractor {
    
    // MARK: - Internal Properties -
    var presenter: TvListPresentationLogic?
    
}

// MARK: - TvListBusinessLogic Implementation -
extension TvListInteractor: TvListBusinessLogic {
    
    func searchShow(byName name: String) {
        let req = Endpoint.Search(name: name)
        ApiClient.shared.doRequest(req: req) {
            [weak self] (result: ApiResult<[TvShowModel]>) in
            switch(result) {
            case .success(let data):
                self?.presenter?.presentShows(data)
            default:
                break
            }
        }
    }
    
    func getShows(byPage page: Int) {
        let req = Endpoint.Shows(page: page)
        ApiClient.shared.doRequest(req: req) {
            [weak self] (result: ApiResult<[TvShowInfoModel]>) in
            switch(result) {
            case .success(let data):
                self?.presenter?.presentShows(data)
            default:
                break
            }
        }
    }
    
}
