//
//  TvListContract.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

protocol TvListBusinessLogic: AnyObject {
    func searchShow(byName name: String)
    func getShows(byPage page: Int)
}

protocol TvListPresentationLogic: AnyObject {
    func presentShows(_ shows: [TvShowModel])
    func presentShows(_ shows: [TvShowInfoModel])
}

protocol TvListDisplayLogic: AnyObject {
    func displayShows(_ shows: [TvShowViewModel])
}
