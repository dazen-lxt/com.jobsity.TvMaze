//
//  TvShowPresenter.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

class TvShowPresenter {
    
    // MARK: - Internal Properties -
    weak var view: TvShowDisplayLogic?
    
}

// MARK: - TvListPresentationLogic Implementation -
extension TvShowPresenter: TvShowPresentationLogic {
    
    func presentShowDetail(_ show: TvShowInfoModel) {
        var scheduledTime = ""
        if let days = show.schedule?.days {
            scheduledTime = days.joinWords()
            if let time = show.schedule?.time {
                scheduledTime += ": \(time)"
            }
        }
        let viewModel = TvShowViewModel(
            id: show.id,
            name: show.name,
            genres: show.genres.joinWords(),
            imageUrl: URL(string: show.image?.medium ?? ""),
            summary: show.summary ?? "",
            time: scheduledTime)
        view?.displayShowDetail(viewModel)
    }
    
    func presentEpisodes(_ episodes: [EpisodeModel]) {
        let episodesBySeason = Dictionary(grouping: episodes, by: { $0.season })
        let viewModels = episodesBySeason.map { item in
            return SeasonViewModel(
                season: item.key,
                episodes: item.value.map { episodeItem in
                    return EpisodeViewModel(
                        name: episodeItem.name,
                        number: episodeItem.number,
                        summary: episodeItem.summary ?? episodeItem.name,
                        imageUrl: URL(string: episodeItem.image?.medium ?? "")
                    )
                }.sorted(by: { $0.number < $1.number })
            )
        }.sorted(by: { $0.season < $1.season })
        view?.displayEpisodes(viewModels)
    }
    
    func presentIsFavorite(_ isFavorite: Bool) {
        view?.displayIsFavorite(isFavorite)
    }
}

