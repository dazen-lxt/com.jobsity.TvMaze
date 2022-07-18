//
//  ApiResult.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

enum ApiResult<T> {
    case success(T)
    case failure(Error, Int)
}
