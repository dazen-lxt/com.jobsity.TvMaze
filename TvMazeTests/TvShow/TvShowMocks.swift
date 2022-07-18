//
//  TvShowMocks.swift
//  TvMazeTests
//
//  Created by Carlos on 18/07/22.
//

import Foundation
@testable import TvMaze

class TvShowDisplayLogicMocks: TvShowDisplayLogic {
    
    var show: TvShowViewModel?
    var episodes: [SeasonViewModel] = []
    var isFavorite: Bool?
    
    func displayShowDetail(_ show: TvShowViewModel) {
        self.show = show
    }
    
    func displayEpisodes(_ episodesBySeason: [SeasonViewModel]) {
        self.episodes = episodesBySeason
    }
    
    func displayIsFavorite(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
    
    
}
