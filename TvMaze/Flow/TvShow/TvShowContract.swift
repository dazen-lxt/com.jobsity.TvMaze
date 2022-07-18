//
//  TvShowContract.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

protocol TvShowBusinessLogic: AnyObject {
    func checkIfIsFavorite(id: Int)
    func getShowDetail(id: Int)
    func getEpisodes(id: Int)
    func toggleFavorite(show: TvShowViewModel)
}

protocol TvShowPresentationLogic: AnyObject {
    func presentShowDetail(_ show: TvShowInfoModel)
    func presentEpisodes(_ episodes: [EpisodeModel])
    func presentIsFavorite(_ isFavorite: Bool)
}

protocol TvShowDisplayLogic: AnyObject {
    func displayShowDetail(_ show: TvShowViewModel)
    func displayEpisodes(_ episodesBySeason: [SeasonViewModel])
    func displayIsFavorite(_ isFavorite: Bool)
}
