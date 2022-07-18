//
//  TvShowInfoModel.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

struct TvShowInfoModel: Codable {
    var id: Int
    var name: String
    var genres: [String]
    var image: TvShowImageModel?
    var summary: String?
    var schedule: TvShowScheduleModel?
}
