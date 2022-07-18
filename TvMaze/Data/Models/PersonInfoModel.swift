//
//  PersonInfoModel.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

struct PersonInfoModel: Codable {
    var id: Int
    var name: String
    var image: TvShowImageModel?
    var birthday: String?
    var deathday: String?
    var country: CountryModel?
}
