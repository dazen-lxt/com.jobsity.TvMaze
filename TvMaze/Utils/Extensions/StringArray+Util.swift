//
//  StringArray+Util.swift
//  TvMaze
//
//  Created by Carlos on 16/07/22.
//

import Foundation

extension Array where Element == String {
    
    func joinWords() -> String {
        let words = joined(separator: ", ")
        return words
    }
}
