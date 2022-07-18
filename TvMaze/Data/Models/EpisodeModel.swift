//
//  EpisodeModel.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

struct EpisodeModel: Codable {
    var id: Int
    var name: String
    var season: Int
    var number: Int
    var summary: String?
    var image: TvShowImageModel?
}
