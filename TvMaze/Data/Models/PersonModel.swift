//
//  PersonModel.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

struct PersonModel: Codable {
    var score: Double
    var person: PersonInfoModel
}

struct XXXX: Codable {
    var score: Double
    var person: YYYY
}

struct YYYY: Codable {
    var id: Int
    var name: String
    var image: TvShowImageModel?
    var birthday: String?
    var deathday: String?
    var country: CountryModel?
}
