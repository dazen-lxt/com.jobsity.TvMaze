//
//  EpisodeViewModel.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

struct EpisodeViewModel {
    var name: String
    var number: Int
    var summary: String
    var imageUrl: URL?
}

struct SeasonViewModel {
    var season: Int
    var episodes: [EpisodeViewModel]
}
